<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>操作日志</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-input style="width: 120px" v-model="req.userName" placeholder="用户名"></el-input>
                <el-input style="width: 120px" v-model="req.logType" placeholder="日志类型"></el-input>
                <el-input style="width: 120px" v-model="req.logName" placeholder="日志名称"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
                <el-button v-if="canClear" type="danger" icon="delete" @click="clearAll">清空日志</el-button>
            </div>
            <el-table :data="tableData" v-loading="loading" border class="table" @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55" align="center"></el-table-column>
                <el-table-column label="日志类型" align="center" prop="logType"></el-table-column>
                <el-table-column label="日志名称" align="center" prop="logName"></el-table-column>
                <el-table-column label="用户名" align="center" prop="userName"></el-table-column>
                <el-table-column label="类名称" align="center" prop="className"></el-table-column>
                <el-table-column label="方法名称" align="center" prop="method"></el-table-column>
                <el-table-column label="是否成功" align="center" prop="succeed"></el-table-column>
                <el-table-column label="备注" align="center" prop="message"></el-table-column>
                <el-table-column label="创建时间" align="center" prop="createTime"></el-table-column>
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
                operationLog: {},
                req: {},
                loading: false,
                canClear:true
            }
        },
        created() {
            this.getData();
            this.canClear = this.$tools.getPerms().indexOf("sys:operationLog:clear")!==-1;
        },
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
            getData() {
                this.loading = true;
                this.req.currentPage = this.page.pageNo;
                this.req.pageSize = this.page.pageSize;
                this.$api.SysOperationLogApi.getData(this.req).then((res) => {
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
            search() {
                this.is_search = true;
                this.getData();
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            clearAll() {
                this.$tools.messageBox('清空日志不可恢复，是否确定清空日志？', this.clear);
            },
            clear(){
                this.$api.SysOperationLogApi.clear().then((res) => {
                    this.$message.success(res.msg);
                    this.reload();
                }, (err) => {
                    this.$message.error(err.msg);
                });
            }
        }
    }

</script>
