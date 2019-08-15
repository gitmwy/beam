<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-input style="width: 150px" v-model="req.beanName" placeholder="请输入bean名称"></el-input>
                <el-select v-model="req.status" placeholder="请选择">
                    <el-option key="" label="全部" value=""></el-option>
                    <el-option v-for="item in statusName" :key="item.id" :label="item.name" :value="item.code"></el-option>
                </el-select>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
                <el-button v-if="canDel" type="danger" icon="delete" @click="delAll">批量删除</el-button>
                <el-button v-if="canAdd" type="primary" icon="add" @click="handleAdd">新增</el-button>
                <el-button v-if="canRun" type="info" @click="handleRun">运行一次</el-button>
                <el-button v-if="canPause" type="danger" @click="handlePause">停止</el-button>
                <el-button v-if="canResume" type="success" @click="handleResume">恢复</el-button>
            </div>
            <el-table :data="tableData" v-loading="loading" border class="table" @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55" align="center"></el-table-column>
                <el-table-column label="bean名称" align="center" prop="beanName"></el-table-column>
                <el-table-column label="方法名" align="center" prop="methodName"></el-table-column>
                <el-table-column label="参数" align="center" prop="params"></el-table-column>
                <el-table-column label="cron表达式" align="center" prop="cronExpression"></el-table-column>
                <el-table-column width="160" label="任务状态" align="center">
                    <template slot-scope="scope">
                        <p>{{ scope.row.statusName }}</p>
                    </template>
                </el-table-column>
                <el-table-column label="备注" align="center" prop="remark"></el-table-column>
                <el-table-column label="创建时间" align="center" prop="createTime"></el-table-column>
                <el-table-column label="更新时间" align="center" prop="updateTime"></el-table-column>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
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
        <el-dialog title="编辑" :visible.sync="editVisible" width="40%">
            <el-form ref="scheduleJob" :model="scheduleJob" label-width="100px">
                <el-form-item label="bean名称" prop="beanName">
                    <el-input v-model.trim="scheduleJob.beanName"></el-input>
                </el-form-item>
                <el-form-item label="方法名" prop="methodName">
                    <el-input v-model.trim="scheduleJob.methodName"></el-input>
                </el-form-item>
                <el-form-item label="参数" prop="params">
                    <el-input v-model.trim="scheduleJob.params"></el-input>
                </el-form-item>
                <el-form-item label="cron表达式" prop="cronExpression">
                    <el-input v-model.trim="scheduleJob.cronExpression"></el-input>
                </el-form-item>
                <el-form-item label="任务状态" prop="status">
                    <el-select v-model="scheduleJob.status" placeholder="请选择">
                        <el-option v-for="item in statusName" :key="item.id" :label="item.name" :value="item.code"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="备注" prop="remark">
                    <el-input v-model.trim="scheduleJob.remark"></el-input>
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
                page: {pageNo: 1, pageSize: 20},
                multipleSelection: [],
                is_search: false,
                editVisible: false,
                isNew: false,
                scheduleJob: {},
                ids: [],
                req: {},
                accountInput: true,
                loading: false,
                statusName: [],
                canEdit:true,
                canAdd:true,
                canDel:true,
                canResume:true,
                canPause:true,
                canRun:true
            }
        },
        created() {
            this.getData();
            this.getStatusList();
            this.canEdit = this.$tools.getPerms().indexOf("sys:schedule:edit")!==-1;
            this.canAdd = this.$tools.getPerms().indexOf("sys:schedule:add")!==-1;
            this.canDel = this.$tools.getPerms().indexOf("sys:schedule:del")!==-1;
            this.canResume = this.$tools.getPerms().indexOf("sys:schedule:resume")!==-1;
            this.canPause = this.$tools.getPerms().indexOf("sys:schedule:pause")!==-1;
            this.canRun = this.$tools.getPerms().indexOf("sys:schedule:run")!==-1;
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
                this.getData();
            },
            getData() {
                this.loading = true;
                this.req.currentPage = this.page.pageNo;
                this.req.pageSize = this.page.pageSize;
                this.$api.SysScheduleApi.getData(this.req).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
                        this.tableData = res.data.records ? res.data.records : [];
                        this.page.pageNo = parseInt(res.data.current);
                        this.page.totalRows = parseInt(res.data.total)
                    }
                }, (err) => {
                    this.loading = false;
                    this.$message.error(err.msg);
                });
            },
            search() {
                this.is_search = true;
                this.getData();
            },

            handleAdd() {
                this.isNew = true;
                this.scheduleJob = {status: 0};
                this.editVisible = true;
            },
            handleEdit(index) {
                this.isNew = false;
                this.scheduleJob = this.$tools.assign(this.tableData[index]);
                this.editVisible = true;
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
            handleRun() {
                this.ids = [];
                const length = this.multipleSelection.length;
                for (let i = 0; i < length; i++) {
                    this.ids.push(this.multipleSelection[i].id);
                }
                this.$tools.messageBox('是否确定运行这些定时任务？', this.runJob);
            },
            handlePause() {
                this.ids = [];
                const length = this.multipleSelection.length;
                for (let i = 0; i < length; i++) {
                    this.ids.push(this.multipleSelection[i].id);
                }
                this.$tools.messageBox('是否确定停止这些定时任务？', this.pauseJob);
            },
            handleResume() {
                this.ids = [];
                const length = this.multipleSelection.length;
                for (let i = 0; i < length; i++) {
                    this.ids.push(this.multipleSelection[i].id);
                }
                this.$tools.messageBox('是否确定恢复这些定时任务？', this.resumeJob);
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            // 保存编辑
            saveEdit() {
                this.loading = true;
                if (this.isNew) {
                    this.$api.SysScheduleApi.add(this.scheduleJob).then((res) => {
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
                } else {
                    this.$api.SysScheduleApi.edit(this.scheduleJob).then((res) => {
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
            },
            // 确定删除
            deleteRow() {
                this.$api.SysScheduleApi.batchDelete(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            // 确定运行
            runJob() {
                this.$api.SysScheduleApi.runJob(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            // 确定暂停
            pauseJob() {
                this.$api.SysScheduleApi.pauseJob(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            // 确定恢复
            resumeJob() {
                this.$api.SysScheduleApi.resumeJob(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            getStatusList() {
                this.$api.SysScheduleApi.statusList().then((res) => {
                    if (res.error === false) {
                        this.statusName = res.data;
                        this.statusName.forEach(item => {
                            item.code = parseInt(item.code);
                        })
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
</style>
