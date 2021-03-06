<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>用户管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <el-container>
                <el-aside width="150px">
                    <el-tree :data="deptTreeData" :props="defaultProps" :expand-on-click-node="false" @node-click="leftDeptClick"></el-tree>
                </el-aside>
                <el-container>
                    <el-header>
                            <el-input style="width: 120px" v-model="req.account" placeholder="请输入账号"></el-input>
                            <el-input style="width: 120px" v-model="req.name" placeholder="请输入姓名"></el-input>
                            <el-button type="primary" icon="search" @click="search">搜索</el-button>
                            <el-button type="primary" icon="el-icon-refresh" @click="refresh">重置</el-button>
                            <el-button v-if="canDel" type="danger" icon="delete" @click="delAll">批量删除</el-button>
                            <el-button v-if="canAdd" type="primary" icon="add" @click="handleAdd">新增用户</el-button>
                    </el-header>
                    <el-main>
                        <el-table :data="tableData" v-loading="loading" border class="table" @selection-change="handleSelectionChange">
                            <el-table-column type="selection" width="55" align="center"></el-table-column>
                            <el-table-column label="用户头像" min-width="120" align="center">
                                <template v-if="scope.row.avatar" slot-scope="scope">
                                    <img :src="scope.row.avatar" style="width: 100px;height: 100px"/>
                                </template>
                            </el-table-column>
                            <el-table-column prop="account" align="center" label="账号"></el-table-column>
                            <el-table-column prop="name" align="center" label="姓名"></el-table-column>
                            <el-table-column prop="sexName" align="center" label="性别"></el-table-column>
                            <el-table-column prop="deptName" align="center" label="部门名称"></el-table-column>
                            <el-table-column prop="companyName" align="center" label="公司名称" :show-overflow-tooltip="true"></el-table-column>
                            <el-table-column prop="email" align="center" label="邮箱" width="200"></el-table-column>
                            <el-table-column prop="phone" align="center" label="手机号" width="150"></el-table-column>
                            <el-table-column prop="birthday" align="center" label="出生日期" width="150"></el-table-column>
                            <el-table-column width="160" label="是否可用" align="center">
                                <template slot-scope="scope">
                                    <el-switch v-model="scope.row.status" :active-text="scope.row.status ? '可用' : '不可用'" inactive-color="#ff4949" @change="changeStatus(scope.row.id, scope.row.status)"></el-switch>
                                </template>
                            </el-table-column>
                            <el-table-column label="操作" width="180" align="center">
                                <template slot-scope="scope">
                                    <el-button v-if="canEdit" type="text" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                                    <el-button v-if="canDel" type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                                    <el-button v-if="canResetPassword" type="text" icon="el-icon-refresh" class="warning" @click="handleResetPassword(scope.row.id)">重置密码</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                        <!--分页-->
                        <div class="pagination">
                            <el-pagination
                                background
                                :page-sizes="[10, 20, 30, 40]"
                                :page-size="page.pageSize"
                                :current-page="page.pageNo"
                                @current-change="handleCurrentChange"
                                @size-change="changePageSize"
                                layout="total, sizes, prev, pager, next, jumper"
                                :total="page.totalRows">
                            </el-pagination>
                        </div>
                    </el-main>
                </el-container>
            </el-container>
        </div>

        <!-- 编辑弹出框 -->
        <el-dialog title="编辑" :visible.sync="editVisible" width="50%" :close-on-press-escape="false"  @close="close">
            <el-form ref="form" :model="form" :rules="rules" label-width="100px">
                <el-upload
                    label=" 头像"
                    class="avatar-uploader el-dialog--center"
                    action="/beam_admin/sys/user/upload"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                    :before-upload="beforeAvatarUpload">
                    <img v-if="form.avatar" :src="form.avatar" class="avatar" key="1"/>
                    <i v-else class="el-icon-plus avatar-uploader-icon" key="2"></i>
                </el-upload>
                <el-form-item label="账号">
                    <el-input :disabled="accountInput" v-model="form.account"></el-input>
                </el-form-item>
                <el-form-item label="姓名">
                    <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item  label="选择角色">
                    <el-select v-model="form.roleIds" multiple placeholder="选择角色">
                        <el-option v-for="item in roleList" :key="item.id" :label="item.roleName" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item  label="部门名称" v-if="deptFlag">
                    <el-input @click.native="goToSelectDept" readonly="readonly" v-model="form.deptName"></el-input>
                </el-form-item>
                <el-form-item label="邮箱" prop="email">
                    <el-input v-model="form.email"></el-input>
                </el-form-item>
                <el-form-item label="手机号" prop="phone">
                    <el-input maxlength="11" v-model="form.phone"></el-input>
                </el-form-item>
                <el-form-item label="性别" prop="sex">
                    <el-switch v-model="form.sex" :active-text="form.sex === 1 ? '男' : '女'" :active-value="1" :inactive-value="2" inactive-color="#ff4949"></el-switch>
                </el-form-item>
                <el-form-item label="出生日期">
                    <el-date-picker type="date" placeholder="选择日期" v-model="form.birthday" format="yyyy-MM-dd" value-format="yyyy-MM-dd"></el-date-picker>
                </el-form-item>
                <el-form-item label="是否可用" prop="status">
                    <el-switch v-model="form.status" :active-text="form.status ? '可用' : '不可用'"></el-switch>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-tag type="danger">新增的用户密码默认:123456</el-tag>
                <el-button @click="editVisible = false">取 消</el-button>
                <el-button type="primary" :loading="loading" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>

        <!-- 编辑弹出框 -->
        <el-dialog title="选择部门" :modal="false" :visible.sync="selectDeptDialog" width="30%">
            <el-tree :data="deptTreeData" :props="defaultProps" :expand-on-click-node="false" @node-click="selectDeptClick"></el-tree>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                selectDeptDialog:false,
                tableData: [],
                page: {pageNo: 1, pageSize: 20},
                multipleSelection: [],
                is_search: false,
                editVisible: false,
                deptFlag: true,
                form: {
                    name: '',
                    account: '',
                    birthday: '',
                    email: '',
                    phone: '',
                    deptId:'',
                    sex:'',
                    roleIds:[]
                },
                rules: {
                    phone: [
                        {required:true, validator: this.$verify.validatePhone, trigger: 'blur'}
                    ],
                    email: [
                        {required:true, validator: this.$verify.validateEMail, trigger: 'blur'}
                    ]
                },
                ids: [],
                req: {},
                accountInput: true,
                loading: false,
                deptTreeData: [],
                defaultProps: {
                    children: 'children',
                    label: 'name'
                },
                roleList:[],
                canEdit:true,
                canAdd:true,
                canDel:true,
                canResetPassword:true
            }
        },
        created() {
            this.getData();
            this.getDeptTreeData();
            this.canEdit = this.$tools.getPerms().indexOf("sys:user:edit")!==-1;
            this.canAdd = this.$tools.getPerms().indexOf("sys:user:add")!==-1;
            this.canDel = this.$tools.getPerms().indexOf("sys:user:del")!==-1;
            this.canResetPassword = this.$tools.getPerms().indexOf("sys:user:resetPassword")!==-1;
        },
        computed: {},
        methods: {
            close(){
                this.deptFlag = true;
            },
            // 重置查询条件
            refresh() {
                this.req = [];
                this.getData();
                this.getDeptTreeData();
            },
            getRoleList() {
                this.$api.SysUserApi.getRoleList().then((res) => {
                    if (res.error === false) {
                        this.roleList = res.data;
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            goToSelectDept(){
                this.selectDeptDialog = true;
            },
            selectDeptClick(data){
                this.selectDeptDialog = false;
                this.form.deptId=data.id;
                this.form.deptName=data.name;
            },
            leftDeptClick(data){
                let deptId = [];
                deptId.push(data.id);
                if(data.children!==''){
                    deptId = this.getChildrenDept(data.children,deptId);
                }
                this.req.deptIds = deptId.join(",");
                this.reload();
            },
            getChildrenDept(data,deptId){
                data.forEach(item=>{
                    deptId.push(item.id);
                    if(item.children!==''){
                        this.getChildrenDept(item.children,deptId);
                    }
                });
                return deptId;
            },
            handleAvatarSuccess(res) {
                if (res.error === false) {
                    this.$set(this.form, "avatar", res.data);
                }
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
            },
            handleCurrentChange(val) {
                this.page.pageNo = val;
                this.getData();
            },
            changePageSize(value) {
                this.page.pageNo = 1;
                this.page.pageSize = value;
                this.tableData = null;
                this.getData()
            },
            reload() {
                this.page.pageNo = 1;
                this.getData()
            },
            // 获取 easy-mock 的模拟数据
            getData() {
                this.loading = true;
                this.req.currentPage = this.page.pageNo;
                this.req.pageSize = this.page.pageSize;
                this.$api.SysUserApi.getData(this.req).then((res) => {
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
            getDeptTreeData() {
                this.$api.SysDeptApi.getTreeData().then((res) => {
                    if (res.error === false) {
                        this.deptTreeData = res.data;
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            search() {
                this.is_search = true;
                this.getData();
            },
            handleAdd() {
                this.form = {};
                this.editVisible = true;
                this.accountInput = false;
                this.form.sex = 1;
                this.form.status = true;
                this.getRoleList();
            },
            handleEdit(index, row) {
                this.$api.SysUserApi.edit({userId:row.id}).then((res) => {
                    if (res.error === false) {
                        if("1" === res.data.id){
                                this.deptFlag = false;
                        }
                        this.form = res.data;
                        this.form.status = Boolean(this.form.status);
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
                this.getRoleList();
                this.editVisible = true;
                this.accountInput = true;
            },
            handleDelete(index, row) {
                this.ids = [row.id];
                this.$tools.messageBox('删除不可恢复，是否确定删除？', this.deleteRow);
            },
            delAll() {
                this.ids = [];
                const length = this.multipleSelection.length;
                for (let i = 0; i < length; i++) {
                    this.ids.push(this.multipleSelection[i].id);
                }
                this.$tools.messageBox('删除不可恢复，是否确定删除？', this.deleteRow);
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            // 保存编辑
            saveEdit() {
                this.$refs.form.validate((valid) => {
                    if(valid){
                        this.loading = true;
                        this.$api.SysUserApi.add(this.form).then((res) => {
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
            // 确定删除
            deleteRow() {
                this.$api.SysUserApi.batchDelete(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            handleResetPassword(id) {
                this.ids = [id];
                this.$tools.messageBox('是否确认将密码重置为：123456？', this.resetPassword);
            },
            resetPassword(){
                this.$api.SysUserApi.resetPassword(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                })
            },
            changeStatus(id, flag) {
                this.$api.SysUserApi.changeStatus(id, !flag ? 0 : 1).then((res) => {
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
    .warning {
        color: #E6A23C;
    }
    .red {
        color: #ff0000;
    }
</style>
