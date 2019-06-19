<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb>
                <el-breadcrumb-item><i class="el-icon-lx-service"></i> 会议列表</el-breadcrumb-item>
                <el-breadcrumb-item><i class="el-icon-lx-right"></i> 查看</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-input style="width: 120px" v-model="req.code" placeholder="会议编号"></el-input>
                <el-input style="width: 120px" v-model="req.hospitalName" placeholder="医院名称"></el-input>
                <el-input style="width: 120px" v-model="req.startTime" placeholder="开始时间"></el-input>到
                <el-input style="width: 120px" v-model="req.endTime" placeholder="结束时间"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
            </div>
            <el-table :data="tableData" v-loading="loading" border class="table" ref="multipleTable">
                <el-table-column type="selection" width="55" align="center"></el-table-column>
                <el-table-column label="编号" align="center" prop="code"></el-table-column>
                <el-table-column label="会议日期" align="center" prop="meetingTime"></el-table-column>
                <el-table-column label="医院名称" align="center" prop="hospitalName"></el-table-column>
                <el-table-column label="所在省市" align="center" prop="city"></el-table-column>
                <el-table-column label="课件" align="center" prop="courseware"></el-table-column>
                <el-table-column label="讲者" align="center" prop="speakers"></el-table-column>
                <el-table-column label="申请日期" align="center" prop="application_time"></el-table-column>
                <el-table-column label="来源" align="center" prop="source"></el-table-column>
                <el-table-column label="操作" align="center" prop="operation"></el-table-column>
            </el-table>
            <div class="pagination">
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
    </div>
</template>

<script>

    import Http from '../../util/http';

    export default {
        name: 'basetable',
        data() {
            return {
                tableData: [],
                page: {pageNo: 1, pageSize: 20},
                is_search: false,
                delVisible: false,
                loginLog: {},
                req: {},
                loading: false
            }
        },
        created() {
            this.getData();
        },
        computed: {},
        methods: {
            handleCurrentChange(val) {
                this.page.pageNo = val;
                this.getData();
            },
            changePageSize(value) { // 修改每页条数size
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
                Http.get("/sys/loginlog/page/list",this.req).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
                        this.tableData = res.data.records ? res.data.records : [];
                        this.page.pageNo = parseInt(res.data.current);
                        this.page.totalRows = parseInt(res.data.total);
                        this.tableData.forEach(item => {
                            item.status = Boolean(item.status)
                        })
                    } else {
                        this.$message.error(res.msg);
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
            clearAll() {
                Http.post("/sys/loginlog/clear",this.reqs).then((res) => {
                    this.delVisible = false;
                    this.$message.success(res.msg);
                    this.reload();
                }, (err) => {
                    this.loading = false;
                    this.$message.error(err.msg);
                });

            },
        }
    }
</script>

<style scoped>
    .handle-box {
        margin-bottom: 20px;
    }
    .table {
        width: 100%;
        font-size: 14px;
    }
</style>
