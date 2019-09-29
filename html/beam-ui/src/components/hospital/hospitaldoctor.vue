<template>
    <div class="table" v-loading="exportLoading">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>医生</el-breadcrumb-item>
                <el-breadcrumb-item>医生列表</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-input style="width: 120px" v-model.trim="req.name" placeholder="医生名字"/>
                <el-input style="width: 120px" v-model.trim="req.phone" placeholder="手机号"/>
                <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
                <el-button type="primary" icon="el-icon-refresh" @click="refresh">重置</el-button>
                <el-button  v-if="canExport" type="success" icon="el-icon-download" @click="exportData">导出数据</el-button>
            </div>
            <el-table :data="tableData" v-loading="loading" border class="table">
                <el-table-column label="医生姓名" align="center" prop="name" width="200"/>
                <el-table-column label="手机号" align="center" prop="phone" width="200"/>
                <el-table-column label="微信昵称" align="center" prop="nickname" width="200"/>
                <el-table-column label="注册日期" align="center" prop="regTime"/>
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
                loading: false,
                exportLoading: false,
                canExport: true
            }
        },
        //初始化
        created() {
            this.getData();
            this.canExport = this.$tools.getPerms().indexOf("hospital:doctor:export")!==-1;
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
                this.$api.HospitalDoctorApi.getData(this.req).then((res) => {
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
            // 搜索
            search() {
                this.getData();
            },
            // 重置查询条件
            refresh() {
                this.req = {};
            },
            //导出数据
            exportData(){
                this.exportLoading = true;
                this.$api.HospitalDoctorApi.export(this.req).then(()=>{
                    this.exportLoading = false;
                });
            },
        }
    }
</script>
