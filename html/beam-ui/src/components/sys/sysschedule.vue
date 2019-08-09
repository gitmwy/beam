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
            <div class="pagination" v-if="tableData && tableData.length>0">
                <el-pagination
                    background
                    :page-sizes="[10, 20, 30, 40, 50]"
                    :page-size="page.pageSize"
                    :current-page="page.pageNo"
                    @current-change="handleCurrentChange"
                    @size-change="changePageSize"
                    layout="prev, pager, next"
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

        <!-- 删除提示框 -->
        <el-dialog title="提示" :visible.sync="delVisible" width="300px" center>
            <div class="del-dialog-cnt">删除不可恢复，是否确定删除？</div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="delVisible = false">取 消</el-button>
                <el-button type="primary" @click="deleteRow">确 定</el-button>
            </span>
        </el-dialog>
        <!-- 运行提示框 -->
        <el-dialog title="提示" :visible.sync="runVisible" width="300px" center>
            <div class="del-dialog-cnt">是否确定运行这些定时任务？</div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="runVisible = false">取 消</el-button>
                <el-button type="primary" @click="runJob">确 定</el-button>
            </span>
        </el-dialog>
        <!-- 停止提示框 -->
        <el-dialog title="提示" :visible.sync="pauseVisible" width="300px" center>
            <div class="del-dialog-cnt">是否确定停止这些定时任务？</div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="pauseVisible = false">取 消</el-button>
                <el-button type="primary" @click="pauseJob">确 定</el-button>
            </span>
        </el-dialog>
        <!-- 恢复提示框 -->
        <el-dialog title="提示" :visible.sync="resumeVisible" width="300px" center>
            <div class="del-dialog-cnt">是否确定恢复这些定时任务？</div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="resumeVisible = false">取 消</el-button>
                <el-button type="primary" @click="resumeJob">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    import ScheduleJobApi from '../../api/sys/sysschedule';
    import http from '../../util/http';

    export default {
        data() {
            return {
                tableData: [],
                page: {pageNo: 1, pageSize: 20},
                multipleSelection: [],
                is_search: false,
                editVisible: false,
                isNew: false,
                delVisible: false,
                runVisible: false,
                pauseVisible: false,
                resumeVisible: false,
                scheduleJob: {},
                idx: -1,
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
            this.canEdit = this.getPerms().indexOf("sys:schedule:edit")!==-1;
            this.canAdd = this.getPerms().indexOf("sys:schedule:add")!==-1;
            this.canDel = this.getPerms().indexOf("sys:schedule:del")!==-1;
            this.canResume = this.getPerms().indexOf("sys:schedule:resume")!==-1;
            this.canPause = this.getPerms().indexOf("sys:schedule:pause")!==-1;
            this.canRun = this.getPerms().indexOf("sys:schedule:run")!==-1;
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
                ScheduleJobApi.getData(this.req).then((res) => {
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
            handleEdit(index, row) {
                this.isNew = false;
                this.editVisible = true;
                this.idx = index;
                const item = this.tableData[index];
                this.scheduleJob = item;
            },
            handleDelete(index, row) {
                this.ids = [row.id];
                this.delVisible = true;
            },
            delAll() {
                this.delVisible = true;
                this.ids = [];
                const length = this.multipleSelection.length;
                for (let i = 0; i < length; i++) {
                    this.ids.push(this.multipleSelection[i].id);
                }
            },
            handleRun() {
                this.runVisible = true;
                this.ids = [];
                const length = this.multipleSelection.length;
                for (let i = 0; i < length; i++) {
                    this.ids.push(this.multipleSelection[i].id);
                }
            },
            handlePause() {
                this.pauseVisible = true;
                this.ids = [];
                const length = this.multipleSelection.length;
                for (let i = 0; i < length; i++) {
                    this.ids.push(this.multipleSelection[i].id);
                }
            },
            handleResume() {
                this.resumeVisible = true;
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
                if (this.isNew) {
                    ScheduleJobApi.add(this.scheduleJob).then((res) => {
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
                    ScheduleJobApi.edit(this.scheduleJob).then((res) => {
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
                ScheduleJobApi.batchDelete(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
                this.delVisible = false;
            },
            // 确定运行
            runJob() {
                ScheduleJobApi.runJob(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
                this.runVisible = false;
            },
            // 确定暂停
            pauseJob() {
                ScheduleJobApi.pauseJob(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
                this.pauseVisible = false;
            },
            // 确定恢复
            resumeJob() {
                ScheduleJobApi.resumeJob(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
                this.resumeVisible = false;
            },
            getStatusList() {
                http.get("/sys/schedule/status/list").then((res) => {
                    if (res.error === false) {
                        this.statusName = res.data;
                        this.statusName.forEach(item => {
                            item.code = parseInt(item.code);
                        })
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            }
        }
    }

</script>

<style scoped>
    .handle-box {
        margin-bottom: 20px;
    }
    .del-dialog-cnt {
        font-size: 16px;
        text-align: center
    }
    .table {
        width: 100%;
        font-size: 14px;
    }
    .red {
        color: #ff0000;
    }
</style>
