<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item> 角色管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-input style="width: 130px" v-model="req.roleName" placeholder="请输入角色名称"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
                <el-button type="primary" icon="el-icon-refresh" @click="refresh">重置</el-button>
                <el-button v-if="canDel" type="danger" icon="delete" @click="delAll">批量删除</el-button>
                <el-button v-if="canAdd" type="primary" icon="add" @click="handleAdd">新增</el-button>
            </div>
            <el-table :data="tableData" v-loading="loading" border class="table" @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55" align="center"></el-table-column>
                <el-table-column label="角色名称" align="center" prop="roleName"></el-table-column>
                <el-table-column label="备注" align="center" prop="remark"></el-table-column>
                <el-table-column label="创建时间" align="center" prop="createTime"></el-table-column>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button v-if="canEdit" type="text" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                        <el-button v-if="canDel" type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                        <el-button v-if="canConfigPerm" class="success" type="text" icon="el-icon-lx-lock" @click="handleConfigPerms(scope.$index, scope.row)">权限配置</el-button>
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
        </div>

        <!-- 编辑弹出框 -->
        <el-dialog title="编辑" :visible.sync="editVisible" width="30%">
            <el-form ref="role" :model="role" label-width="100px">
                <el-form-item label="角色名称" prop="roleName">
                    <el-input v-model.trim="role.roleName"></el-input>
                </el-form-item>
                <el-form-item label="备注" prop="remark">
                    <el-input v-model.trim="role.remark"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible = false">取 消</el-button>
                <el-button type="primary" :loading="loading" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>
        <!-- 编辑弹出框 -->
        <el-dialog title="配置菜单" :visible.sync="configMenuDialog" width="30%">
            <el-tree :check-strictly="true" v-loading="treeLoading" show-checkbox node-key="id" :data="menuTreeData" :default-checked-keys="checkMenuData" :props="defaultProps"  ref="treeMenu" default-expand-all :expand-on-click-node="false"></el-tree>
            <span slot="footer" class="dialog-footer">
                <el-button @click="configMenuDialog = false">取 消</el-button>
                <el-button type="primary" @click="saveRoleMenu">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                configMenuDialog:false,
                tableData: [],
                page: {pageNo: 1, pageSize: 20},
                multipleSelection: [],
                is_search: false,
                editVisible: false,
                role: {},
                ids: [],
                req: {},
                accountInput: true,
                loading: false,
                treeLoading: false,
                menuTreeData: [],
                defaultProps: {
                    children: 'children',
                    label: 'name'
                },
                checkMenuData:[],
                roleId:null,
                canEdit:true,
                canAdd:true,
                canDel:true,
                canConfigPerm:true
            }
        },
        created() {
            this.getData();
            this.canEdit = this.$tools.getPerms().indexOf("sys:role:edit")!==-1;
            this.canAdd = this.$tools.getPerms().indexOf("sys:role:add")!==-1;
            this.canDel = this.$tools.getPerms().indexOf("sys:role:del")!==-1;
            this.canConfigPerm = this.$tools.getPerms().indexOf("sys:role:configPerm")!==-1;
        },
        methods: {
            refresh() {
                this.req = [];
                this.getData();
            },
            saveRoleMenu(){
                this.checkMenuData = [];
                this.checkMenuData = this.checkMenuData.concat(this.$refs.treeMenu.getCheckedKeys());
                this.checkMenuData = this.checkMenuData.concat(this.$refs.treeMenu.getHalfCheckedKeys());
                this.$api.SysRoleApi.saveRoleMenu({id:this.roleId,menuIds:this.checkMenuData}).then((res) => {
                    this.configMenuDialog = false;
                    this.checkMenuData = [];
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload();
                    }
                }, (err) => {
                    this.checkMenuData = [];
                    this.$message.error(err.msg);
                });
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
            getData() {
                this.loading = true;
                this.req.currentPage = this.page.pageNo;
                this.req.pageSize = this.page.pageSize;
                this.$api.SysRoleApi.getData(this.req).then((res) => {
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
            getMenuTreeData() {
                this.$api.SysRoleApi.getMenuTreeData().then((res) => {
                    if (res.error === false) {
                        this.menuTreeData = res.data;
                    }
                }, (err) => {
                    this.treeLoading = false;
                    this.$message.error(err.msg);
                });
            },
            getCheckMenuData(roleId) {
                this.$api.SysRoleApi.getCheckMenuData({roleId:roleId}).then((res) => {
                    if (res.error === false) {
                        this.checkMenuData = res.data;
                        this.treeLoading = false;
                    }
                }, (err) => {
                    this.treeLoading = false;
                    this.$message.error(err.msg);
                });
            },
            search() {
                this.is_search = true;
                this.getData();
            },
            handleAdd() {
                this.role = {};
                this.editVisible = true;
            },
            handleEdit(index) {
                this.role = this.$tools.assign(this.tableData[index]);
                this.editVisible=true;
            },
            handleConfigPerms(index, row) {
                this.treeLoading=true;
                this.roleId = row.id;
                this.checkMenuData=[];
                this.menuTreeData=[];
                this.getMenuTreeData();
                this.getCheckMenuData(this.roleId);
                this.configMenuDialog = true;
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
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            // 保存编辑
            saveEdit() {
                this.loading = true;
                this.$api.SysRoleApi.add(this.role).then((res) => {
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
            },
            // 确定删除
            deleteRow() {
                this.$api.SysRoleApi.batchDelete(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
        }
    }

</script>

<style scoped>
    .success {
        color: #67C23A;
    }
    .red {
        color: #ff0000;
    }
</style>
