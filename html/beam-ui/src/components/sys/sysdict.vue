<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-input style="width: 120px" v-model="req.keyword" placeholder="请输入关键字"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
                <el-button v-if="canAdd" type="primary" icon="add" class="handle-del mr10" @click="handleAdd">新增</el-button>
            </div>
            <el-table :data="tableData" v-loading="loading" border class="table" @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55" align="center"></el-table-column>
                <el-table-column label="名称" align="center" prop="name"></el-table-column>
                <el-table-column label="描述" align="center" prop="des"></el-table-column>
                <el-table-column label="编码" align="center" prop="code"></el-table-column>
                <el-table-column label="排序" align="center" prop="sort"></el-table-column>
                <el-table-column label="创建时间" align="center" prop="createTime"></el-table-column>
                <el-table-column label="更新时间" align="center" prop="updateTime"></el-table-column>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button v-if="canInfo" type="text" class="yellow" icon="el-icon-zoom-in" @click="handleView(scope.$index, scope.row)">查看字典值</el-button>
                        <el-button v-if="canEdit" type="text" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                        <el-button v-if="canDel" type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
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
            <el-form ref="dict" :model="dict" :rules="rules" label-width="100px">
                <el-form-item label="父级字典" prop="pid">
                    <el-select v-model="dict.pid" placeholder="请选择">
                        <el-option v-for="item in dictList" :key="item.id" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="名称" prop="name">
                    <el-input v-model.trim="dict.name"></el-input>
                </el-form-item>
                <el-form-item label="描述" prop="des">
                    <el-input v-model.trim="dict.des"></el-input>
                </el-form-item>
                <el-form-item label="编码" prop="code">
                    <el-input v-model.trim="dict.code"></el-input>
                </el-form-item>
                <el-form-item label="排序" prop="sort">
                    <el-input v-model.trim="dict.sort"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible = false">取 消</el-button>
                <el-button type="primary" :loading="loading" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>

        <el-dialog title="字典值" :visible.sync="subDictVisible">
            <el-table :data="subDictList">
                <el-table-column label="名称" align="center" prop="name"></el-table-column>
                <el-table-column label="描述" align="center" prop="des"></el-table-column>
                <el-table-column label="编码" align="center" prop="code"></el-table-column>
                <el-table-column label="排序" align="center" prop="sort"></el-table-column>
                <el-table-column label="创建时间" align="center" prop="createTime"></el-table-column>
                <el-table-column label="更新时间" align="center" prop="updateTime"></el-table-column>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button type="text" icon="el-icon-edit" @click="subHandleEdit(scope.$index, scope.row)">编辑</el-button>
                        <el-button type="text" icon="el-icon-delete" class="red" @click="subHandleDelete(scope.$index, scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                tableData: [],
                page: {pageNo: 1, pageSize: 20},
                multipleSelection: [],
                is_search: false,
                editVisible: false,
                subDictVisible: false,
                dict: {},
                ids: [],
                req: {},
                accountInput: true,
                loading: false,
                rules: {
                    name: [
                        {required: true, message: '请填写字典名称', trigger: 'blur'},
                    ],
                    code: [
                        {required: true, message: '请填写字典编码', trigger: 'blur'},
                    ],
                },
                dictList: [],
                subDictList: [],
                mark: 0,
                pid: 0,
                canEdit: true,
                canAdd: true,
                canDel: true,
                canInfo: true
            }
        },
        created() {
            this.getData();
            this.canEdit = this.$tools.getPerms().indexOf("sys:dict:edit")!==-1;
            this.canAdd = this.$tools.getPerms().indexOf("sys:dict:add")!==-1;
            this.canDel = this.$tools.getPerms().indexOf("sys:dict:del")!==-1;
            this.canInfo = this.$tools.getPerms().indexOf("sys:dict:info")!==-1;
        },
        computed: {},
        methods: {
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
            subReload() {
                this.getSubData();
            },
            getSubData() {
                this.$api.SysDictApi.getData({pid: this.pid}).then((res) => {
                    if (res.error === false) {
                        this.subDictList = res.data.records ? res.data.records : []
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            getData() {
                this.loading = true;
                this.req.currentPage = this.page.pageNo;
                this.req.pageSize = this.page.pageSize;
                this.$api.SysDictApi.getData(this.req).then((res) => {
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
            getDictList() {
                this.$api.SysDictApi.getDictList().then((res) => {
                    if (res.error === false) {
                        this.dictList = res.data;
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
                this.editVisible = true;
                this.getDictList();
            },
            handleEdit(index,) {
                this.getDictList();
                this.dict = this.$tools.assign(this.tableData[index]);
                this.editVisible = true;
            },
            subHandleEdit(index) {
                this.getDictList();
                this.dict = this.$tools.assign(this.tableData[index]);
                this.mark = 1;
                this.editVisible = true;
            },
            handleView(index) {
                this.dict = this.$tools.assign(this.tableData[index]);
                this.pid = this.dict.id;
                this.getSubData();
                this.subDictVisible = true;
            },
            handleDelete(index, row) {
                this.ids = [row.id];
                this.$tools.messageBox('删除不可恢复，是否确定删除？', this.deleteRow);
            },
            subHandleDelete(index, row) {
                this.ids = [row.id];
                this.mark = 1;
                this.$tools.messageBox('删除不可恢复，是否确定删除？', this.deleteRow);
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            // 保存编辑
            saveEdit() {
                this.loading = true;
                this.$api.SysDictApi.add(this.dict).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
                        this.editVisible = false;
                        this.$message.success(res.msg);
                        if (this.mark === 1) {
                            this.subReload();
                            this.mark = 0;
                        } else {
                            this.reload()
                        }
                    }
                }, (err) => {
                    this.loading = false;
                    this.$message.error(err.msg);
                })
            },
            // 确定删除
            deleteRow() {
                this.$api.SysDictApi.batchDelete(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        if (this.mark === 1) {
                            this.subReload();
                            this.mark = 0;
                        } else {
                            this.reload();
                        }
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
        }
    }

</script>

<style scoped>
    .red {
        color: #ff0000;
    }
    .yellow {
        color: #e6a23c;
    }
</style>
