<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>企业管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-input style="width: 150px" v-model="req.name" placeholder="请输入部门名称"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
                <el-button v-if="canDel" type="danger" icon="delete" @click="delAll">批量删除</el-button>
                <el-button v-if="canAdd" type="primary" icon="add" @click="handleAdd">新增</el-button>
            </div>
            <el-table row-key="id" :data="treeData" v-loading="loading" border class="table" @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55" align="center"></el-table-column>
                <el-table-column label="公司名称" align="center" prop="name"></el-table-column>
                <el-table-column label="排序" align="center" prop="orderNum"></el-table-column>
                <el-table-column label="创建时间" align="center" prop="createTime"></el-table-column>
                <el-table-column label="更新时间" align="center" prop="updateTime"></el-table-column>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button v-if="canEdit" type="text" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                        <el-button v-if="canDel" type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <!-- 编辑弹出框 -->
        <el-dialog title="编辑(父级空，名称即为公司名)" :visible.sync="editVisible" width="50%">
            <el-form ref="dept" :model="dept" label-width="100px">
                <el-form-item label="父级" prop="parentId">
                    <el-input @click.native="goToSelectDept" readonly="readonly" v-model.trim="dept.pname"></el-input>
                </el-form-item>
                <el-form-item label="名称" prop="name">
                    <el-input v-model.trim="dept.name"></el-input>
                </el-form-item>
                <el-form-item label="排序" prop="orderNum">
                    <el-input v-model.trim="dept.orderNum"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible = false">取 消</el-button>
                <el-button type="primary" :loading="loading" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>
        <el-dialog title="选择部门" :modal="false" :visible.sync="selectDeptDialog" width="30%">
            <el-tree :data="treeData" :props="defaultProps" :expand-on-click-node="false" @node-click="selectDeptClick"></el-tree>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                selectDeptDialog: false,
                treeData: [],
                is_search: false,
                editVisible: false,
                multipleSelection: [],
                dept: {},
                ids: [],
                req: {},
                loading: false,
                defaultProps: {
                    children: 'children',
                    label: 'name'
                },
                canEdit:true,
                canAdd:true,
                canDel:true
            }
        },
        created() {
            this.getTreeData();
            this.canEdit = this.$tools.getPerms().indexOf("sys:dept:edit")!==-1;
            this.canAdd = this.$tools.getPerms().indexOf("sys:dept:add")!==-1;
            this.canDel = this.$tools.getPerms().indexOf("sys:dept:del")!==-1;
        },
        methods: {
            refresh() {
                this.treeData = [];
                this.req = [];
                this.getTreeData();
            },
            goToSelectDept() {
                this.selectDeptDialog = true;
            },
            selectDeptClick(data) {
                this.selectDeptDialog = false;
                this.dept.parentId = data.id;
                this.dept.pname = data.name;
            },
            reload() {
                this.getTreeData();
            },
            getTreeData() {
                this.loading = true;
                this.$api.SysDeptApi.getTreeData(this.req).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
                        this.treeData = res.data;
                    }
                }, (err) => {
                    this.loading = false;
                    this.$message.error(err.msg);
                });
            },
            search() {
                this.is_search = true;
                this.treeData = [];
                this.getTreeData();
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            handleAdd() {
                this.dept = {};
                this.editVisible = true;
            },
            handleEdit(index, row) {
                this.$api.SysDeptApi.edit({deptId: row.id}).then((res) => {
                    if (res.error === false) {
                        this.dept = res.data;
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
                this.editVisible = true;
            },
            handleDelete(index, row) {
                this.ids = [row.id];
                this.$tools.messageBox('删除不可恢复，关联的所有部门都将删除，是否确定删除？', this.deleteRow);
            },
            delAll() {
                this.ids = [];
                const length = this.multipleSelection.length;
                for (let i = 0; i < length; i++) {
                    this.ids.push(this.multipleSelection[i].id);
                }
                this.$tools.messageBox('删除不可恢复，关联的所有部门都将删除，是否确定删除？', this.deleteRow);
            },
            // 保存编辑
            saveEdit() {
                this.loading = true;
                this.$api.SysDeptApi.add(this.dept).then((res) => {
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
                this.$api.SysDeptApi.batchDelete(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            }
        }
    }
</script>

<style scoped>
    .red {
        color: #ff0000;
    }
</style>
