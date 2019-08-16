<template>
    <div class="table" v-loading="exportLoading">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>用户</el-breadcrumb-item>
                <el-breadcrumb-item>用户列表</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-input style="width: 120px" v-model.trim="req.username" placeholder="姓名"/>
                <el-select v-model="req.roleId" placeholder="角色">
                    <el-option v-for="item in roleList" :key="item.id" :label="item.roleName" :value="item.id"></el-option>
                </el-select>
                <el-cascader
                    clearable
                    v-model="req.areaId"
                    :options="areaItems"
                    :props="defaultProps"
                    placeholder="区域"
                    :show-all-levels="false">
                </el-cascader>
                <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
                <el-button type="primary" icon="el-icon-refresh" @click="refresh">重置</el-button>
                <el-button v-if="canAdd" type="primary" icon="add" @click="handleAdd">新增用户</el-button>
                <el-button  v-if="canExport" type="success" icon="el-icon-download" @click="exportData">导出数据</el-button>
            </div>
            <el-table :data="tableData" v-loading="loading" border class="table">
                <el-table-column label="编号" align="center" prop="jobCode"/>
                <el-table-column label="头像" min-width="120" align="center">
                    <template v-if="scope.row.avatar" slot-scope="scope">
                        <img :src="scope.row.avatar" style="width: 100px;height: 100px"/>
                    </template>
                </el-table-column>
                <el-table-column label="昵称" align="center" prop="nickname"/>
                <el-table-column label="姓名" align="center" prop="username"/>
                <el-table-column label="手机号" align="center" prop="phone" width="120"/>
                <el-table-column label="区域" align="center" prop="areaName"/>
                <el-table-column label="角色" align="center" prop="roleName"/>
                <el-table-column label="绑定时间" align="center" prop="boundTime" width="200"/>
                <el-table-column width="160" label="状态" align="center">
                    <template slot-scope="scope">
                        <el-switch v-model="scope.row.status" :active-text="scope.row.status ? '正常' : '锁定'" inactive-color="#ff4949" @change="changeStatus(scope.row.id, scope.row.status)"></el-switch>
                    </template>
                </el-table-column>
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
            <el-form ref="user" :model="user" :rules="rules" label-width="100px">
                <el-upload
                    v-loading="loading"
                    label="头像"
                    class="avatar-uploader el-dialog--center"
                    action="/beam_ht/file/upload"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                    :before-upload="beforeAvatarUpload">
                    <img v-if="user.avatar" :src="user.avatar" class="avatar"/>
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
                <el-form-item label="昵称">
                    <el-input v-model.trim="user.nickname" placeholder="请输入昵称"></el-input>
                </el-form-item>
                <el-form-item label="姓名" prop="username">
                    <el-input v-model.trim="user.username" placeholder="请输入姓名"></el-input>
                </el-form-item>
                <el-form-item label="手机号" prop="phone">
                    <el-input v-model.trim="user.phone" placeholder="请输入手机号" maxlength="11"></el-input>
                </el-form-item>
                <div class="cascader">
                    <el-form-item label="所属区域" prop="areaId">
                        <el-cascader
                            clearable
                            v-model="user.areaId"
                            :options="areaItems"
                            :props="defaultProps"
                            placeholder="请选择所属区域"
                            :show-all-levels="false">
                        </el-cascader>
                    </el-form-item>
                </div>
                <el-form-item label="所属角色" prop="roleId">
                    <el-select v-model="user.roleId" placeholder="请选择所属角色">
                        <el-option v-for="item in roleList" :key="item.id" :label="item.roleName" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="是否锁定">
                    <el-switch v-model="user.status" :active-text="user.status ? '正常' : '锁定'" inactive-color="#ff4949"></el-switch>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible = false">取 消</el-button>
                <el-button type="primary" :loading="loading" @click="saveEdit">确 定</el-button>
            </span>
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
                editVisible: false,
                req: {},
                areaItems: [],
                roleList: [],
                user: {},
                ids: [],
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
                    username: [
                        {required: true, message: '请输入姓名', trigger: 'blur'},
                    ],
                    phone: [
                        {required:true, validator: this.$verify.validatePhone, trigger: 'blur'},
                    ]
                },
                canExport: true,
                canAdd: true,
                canEdit: true,
                canDel: true
            }
        },
        //初始化
        created() {
            this.getUserArea();
            this.getUserRole();
            this.getData();
            this.canExport = this.$tools.getPerms().indexOf("user:detail:export")!==-1;
            this.canAdd = this.$tools.getPerms().indexOf("user:detail:add")!==-1;
            this.canEdit = this.$tools.getPerms().indexOf("user:detail:edit")!==-1;
            this.canDel = this.$tools.getPerms().indexOf("user:detail:del")!==-1;
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
                this.$api.UserDetailApi.getData(this.req).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
                        this.tableData = res.data.records ? res.data.records : [];
                        this.page.pageNo = parseInt(res.data.current);
                        this.page.totalRows = parseInt(res.data.total);
                        this.tableData.forEach(item => {
                            item.status = Boolean(item.status)
                        })
                    }
                }, (err) => {
                    this.loading = false;
                    this.$message.error(err.msg);
                });
            },
            handleAvatarSuccess(res) {
                if (res.error === false) {
                    this.$set(this.user, "avatar", res.data);
                }
                this.loading = false;
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isPNG = file.type === 'image/png';
                const isLt2M = file.size / 1024 / 1024 < 2;
                if (!isJPG&&!isPNG) {
                    this.$message.error('上传头像图片只能是 JPG 格式!');
                    return false;
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 2MB!');
                    return isLt2M;
                }
                this.loading = true;
            },
            getUserArea(){
                this.$api.UserDetailApi.userArea().then((res) => {
                    if (res.error === false) {
                        this.areaItems = this.$tools.getTreeData(res.data);
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            getUserRole(){
                this.$api.UserDetailApi.userRole().then((res) => {
                    if (res.error === false) {
                        this.roleList = res.data;
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
                this.user = {};
                this.$refs.user.clearValidate();
            },
            //导出数据
            exportData(){
                this.exportLoading = true;
                this.$api.UserDetailApi.export(this.req).then(()=>{
                    this.exportLoading = false;
                });
            },
            handleAdd(){
                this.user.status = true;
                this.editVisible = true;
            },
            handleEdit(index){
                this.user = this.$tools.assign(this.tableData[index]);
                this.editVisible = true;
            },
            reload() {
                this.getData();
            },
            saveEdit(){
                this.$refs.user.validate((valid) =>{
                    if(valid){
                        this.loading = true;
                        this.$api.UserDetailApi.add(this.user).then((res) => {
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
                this.$api.UserDetailApi.batchDelete(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload();
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            changeStatus(id, flag) {
                this.$api.UserDetailApi.changeStatus(id, !flag ? 0 : 1).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                })
            }
        }
    }
</script>

<style>
    .avatar-uploader .el-upload {
        border: 1px dashed #d9d9d9;
        border-radius: 6px;
        cursor: pointer;
        position: relative;
        overflow: hidden;
        width: 100px;
        height: 100px;
    }
    .avatar-uploader .el-upload:hover {
        border-color: #409EFF;
    }
    .avatar-uploader-icon {
        font-size: 28px;
        color: #8c939d;
        width: 100px;
        height: 100px;
        line-height: 100px;
        text-align: center;
    }
    .avatar {
        width: 100px;
        height: 100px;
        display: block;
    }
    .cascader .el-cascader{
        width: 100%;
    }
    .red {
     color: #ff0000;
    }
</style>
