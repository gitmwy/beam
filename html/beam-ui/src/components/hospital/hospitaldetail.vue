<template>
    <div class="table" v-loading="exportLoading">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>医生</el-breadcrumb-item>
                <el-breadcrumb-item>医院列表</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-input style="width: 120px" v-model.trim="req.code" placeholder="医院编号"/>
                <el-input style="width: 120px" v-model.trim="req.name" placeholder="医院名称"/>
                <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
                <el-button type="primary" icon="el-icon-refresh" @click="refresh">重置</el-button>
                <el-button v-if="canAdd" type="primary" icon="add" @click="handleAdd">新增医院</el-button>
                <el-button  v-if="canExport" type="success" icon="el-icon-download" @click="exportData">导出数据</el-button>
            </div>
            <el-table :data="tableData" v-loading="loading" border class="table">
                <el-table-column label="#" align="center" prop="id"/>
                <el-table-column label="医院编号" align="center" prop="code"/>
                <el-table-column label="医院名称" align="center" prop="name"/>
                <el-table-column label="医院级别" align="center" prop="level"/>
                <el-table-column label="区域" align="center" prop="areaName" width="200"/>
                <el-table-column label="医院地址" align="center" prop="address"/>
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
        <el-dialog title="编辑" :visible.sync="editVisible" width="50%" @close="handleClose">
            <el-form ref="hospital" :model="hospital" :rules="rules" label-width="100px">
                <el-form-item label="医院名称" prop="name">
                    <el-input v-model.trim="hospital.name" placeholder="请输入昵称"></el-input>
                </el-form-item>
                <el-form-item label="医院级别" prop="level">
                    <el-input v-model.trim="hospital.level" placeholder="请输入账号名"></el-input>
                </el-form-item>
                <div class="cascader">
                    <el-form-item label="所属区域" prop="areaId">
                        <el-cascader
                            clearable
                            ref="cascaderAddr"
                            v-model="hospital.areaId"
                            :options="areaItems"
                            :props="defaultProps"
                            placeholder="请选择所属区域"
                            :show-all-levels="false">
                        </el-cascader>
                    </el-form-item>
                </div>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="editVisible = false">取 消</el-button>
                    <el-button type="primary" :loading="loading" @click="saveEdit">确 定</el-button>
                </span>
            </el-form>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                tableData: [],
                page: {pageNo: 1, pageSize: 10},
                is_search: false,
                req: {},
                hospital: {},
                areaItems: [],
                editVisible: false,
                loading: false,
                exportLoading: false,
                defaultProps: {
                    children: 'children',
                    label: 'areaName',
                    value: 'id',
                    checkStrictly: true,
                    emitPath: false
                },
                rules: {
                    name: [
                        {required: true, message: '请输入医院名', trigger: 'blur'},
                    ],
                    level: [
                        {required: true, message: '请输入医院级别', trigger: 'blur'},
                    ]
                },
                canAdd: true,
                canEdit: true,
                canDel: true,
                canExport: true
            }
        },
        //初始化
        created() {
            this.getHospitalArea();
            this.getData();
            this.canAdd = this.$tools.getPerms().indexOf("hospital:detail:add")!==-1;
            this.canEdit = this.$tools.getPerms().indexOf("hospital:detail:edit")!==-1;
            this.canDel = this.$tools.getPerms().indexOf("hospital:detail:del")!==-1;
            this.canExport = this.$tools.getPerms().indexOf("hospital:detail:export")!==-1;
        },
        methods: {
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
                this.$api.HospitalDetailApi.getData(this.req).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
                        console.log(res);
                        this.tableData = res.data.records ? res.data.records : [];
                        this.page.pageNo = parseInt(res.data.current);
                        this.page.totalRows = parseInt(res.data.total);
                    }
                }, (err) => {
                    this.loading = false;
                    this.$message.error(err.msg);
                });
            },
            getHospitalArea(){
                this.$api.HospitalDetailApi.hospitalArea().then((res) => {
                    if (res.error === false) {
                        this.areaItems = this.$tools.getTreeData(res.data);
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            handleAdd(){
                this.editVisible = true;
            },
            handleEdit(index){
                this.hospital = this.$tools.assign(this.tableData[index]);
                this.editVisible = true;
            },
            saveEdit(){
                this.$refs.hospital.validate((valid) =>{
                    if(valid){
                        this.loading = true;
                        this.$api.HospitalDetailApi.add(this.hospital).then((res) => {
                            this.loading = false;
                            if (res.error === false) {
                                this.editVisible = false;
                                this.$message.success(res.msg);
                                this.reload();
                            }
                        }, (err) => {
                            this.loading = false;
                            this.$message.error(err.msg);
                        })
                    }
                })
            },
            handleDelete(index, row) {
                this.ids = [row.id];
                this.$tools.messageBox('删除不可恢复，是否确定删除？', this.deleteRow);
            },
            deleteRow(){
                this.$api.HospitalDetailApi.batchDelete(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload();
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            // 搜索
            search() {
                this.getData();
            },
            // 重置查询条件
            refresh() {
                this.req = {};
            },
            handleClose(){
                this.hospital = {};
                this.$refs.user.clearValidate();
            },
            //导出数据
            exportData(){
                this.exportLoading = true;
                this.$api.HospitalDetailApi.export(this.req).then(()=>{
                    this.exportLoading = false;
                });
            },
        }
    }
</script>

<style>
    .cascader .el-cascader{
        width: 100%;
    }
    .red {
        color: #ff0000;
    }
</style>
