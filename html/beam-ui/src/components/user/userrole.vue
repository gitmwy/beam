<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>用户</el-breadcrumb-item>
                <el-breadcrumb-item>角色管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-select v-model="req.level" placeholder="请选择等级">
                    <el-option v-for="item in levelList" :key="item.id" :label="item.paramValue" :value="item.paramKey"></el-option>
                </el-select>
                <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
                <el-button type="primary" icon="el-icon-refresh" @click="refresh">重置</el-button>
                <el-button v-if="canAdd" type="primary" icon="add" @click="handleAdd">新增角色</el-button>
            </div>
            <el-table :data="tableData" v-loading="loading" border class="table">
                <el-table-column label="#" width="50" prop="id" align="center"></el-table-column>
                <el-table-column label="角色名称" align="center" prop="roleName" width="300"/>
                <el-table-column label="等级" align="center" prop="levelName"/>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button v-if="canEdit" type="text" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row, $event)">编辑</el-button>
                        <el-button v-if="canDel" type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <!--            分页-->
            <div class="pagination">
                <el-pagination
                    background
                    :page-sizes="[10, 20, 30, 40, 50]"
                    :page-size="page.pageSize"
                    :current-page="page.pageNo"
                    @current-change="handleCurrentChange"
                    @size-change="changePageSize"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="page.totalRows">
                </el-pagination>
            </div>
        </div>

        <!-- 编辑弹出框 -->
        <el-dialog title="编辑" :visible.sync="editVisible" width="40%" @close="handleClose">
            <el-form ref="role" :model="role" :rules="rules" label-width="100px">
                <el-form-item label="角色等级" prop="levelName">
                    <el-select v-model.trim="role.levelName" placeholder="请选择等级" @change="goToSelectLevel">
                        <el-option v-for="item in levelList" :key="item.id" :label="item.paramValue" :value="`${item.paramKey}|${item.paramValue}`"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="角色名称" prop="roleName">
                    <el-input v-model.trim="role.roleName" placeholder="请输入自定义名称"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible = false">取 消</el-button>
                <el-button type="primary" :loading="loading" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>

        <!-- 删除提示框 -->
        <el-dialog title="提示" :visible.sync="delVisible" width="300px" center>
            <div class="del-dialog-cnt">删除不可恢复，是否确定删除？</div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="delVisible = false">取 消</el-button>
                <el-button type="primary" @click="deleteRow">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    import UserRoleApi from '../../api/user/userrole';

    export default {
        data() {
            return {
                tableData: [],
                levelList: [],
                page: {pageNo: 1, pageSize: 10},
                delVisible: false,
                editVisible: false,
                req: {},
                role: {},
                ids: [],
                rules: {
                    levelName: [
                        {required: true, message: '请选择角色等级', trigger: 'blur'},
                    ],
                    roleName: [
                        {required: true, message: '请输入角色名称', trigger: 'blur'},
                    ]
                },
                loading: false,
                canAdd: true,
                canEdit: true,
                canDel: true
            }
        },
        //初始化
        created() {
            this.getRoleLevel();
            this.getData();
            this.canAdd = this.getPerms().indexOf("user:role:add")!==-1;
            this.canEdit = this.getPerms().indexOf("user:role:edit")!==-1;
            this.canDel = this.getPerms().indexOf("user:role:del")!==-1;
        },
        methods: {
            getRoleLevel(){
                UserRoleApi.getRoleLevel().then((res) => {
                    if (res.error === false) {
                        this.levelList = res.data;
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            handleCurrentChange(val) {
                this.page.pageNo = val;
                this.getData();
            },
            // 修改每页条数size
            changePageSize(value) {
                this.page.pageNo = 1;
                this.page.pageSize = value;
                this.tableData = null;
                this.getData()
            },
            //获取表格数据
            getData() {
                this.loading = true;
                this.req.currentPage = this.page.pageNo;
                this.req.pageSize = this.page.pageSize;
                UserRoleApi.getData(this.req).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
                        this.tableData = res.data.records ? res.data.records : [];
                        this.page.pageNo = parseInt(res.data.current);
                        this.page.totalRows = parseInt(res.data.total);
                    }
                }, (err) => {
                    this.loading = false;
                    this.$message.error(err.msg);
                });
            },
            // 搜索
            search() {
                this.getData();
            },
            // 重置查询条件
            refresh() {
                this.req = [];
            },
            handleClose(){
                this.role = {};
                this.$refs.role.clearValidate();
            },
            handleAdd(){
                this.editVisible = true;
            },
            handleEdit(index){
                this.role = this.tableData[index];
                this.editVisible=true;
            },
            goToSelectLevel(data){
                let [id, name] = data.split("|");
                this.role.level = id;
                this.role.levelName = name;
            },
            saveEdit(){
                this.$refs.role.validate((valid) =>{
                    if(valid){
                        this.loading = true;
                        UserRoleApi.add(this.role).then((res) => {
                            this.loading = false;
                            if (res.error === false) {
                                this.editVisible = false;
                                this.$message.success(res.msg);
                                this.reload()
                            }
                        }, (err) => {
                            this.loading = false;
                            this.$message.error(err.msg);
                        })
                    }
                })
            },
            reload() {
                this.getData();
            },
            handleDelete(index, row) {
                this.ids = [row.id];
                this.delVisible = true;
            },
            deleteRow(){
                UserRoleApi.batchDelete(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload();
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
                this.delVisible = false;
            }
        }
    }
</script>
