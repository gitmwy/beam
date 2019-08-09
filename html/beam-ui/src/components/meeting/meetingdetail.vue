<template>
    <div class="table" v-loading="exportLoading">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>会议</el-breadcrumb-item>
                <el-breadcrumb-item>会议列表</el-breadcrumb-item>
                <el-breadcrumb-item v-for="(item, index) in items" :key="index">{{item.title}}</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container" v-show="showMeeting">
            <div class="handle-box">
                <el-input style="width: 120px" v-model="req.code" placeholder="会议编号"/>
                <el-input style="width: 120px" v-model="req.hospitalName" placeholder="医院名称"/>
                <el-date-picker v-model="req.startTime" type="date" format="yyyy-MM-dd" value-format="yyyy-MM-dd" placeholder="选择开始时间"/>到
                <el-date-picker v-model="req.endTime" type="date" format="yyyy-MM-dd" value-format="yyyy-MM-dd" placeholder="选择结束时间"/>
                <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
                <el-button type="primary" icon="el-icon-refresh" @click="refresh">重置</el-button>
                <el-button  v-if="canExport" type="success" icon="el-icon-download" @click="exportData">导出数据</el-button>
            </div>
            <el-tabs v-model="initTab" @tab-click="handleClick">
                <el-tab-pane label="全部" name="0" flag=""/>
                <el-tab-pane label="待审核" name="1" flag="01"/>
                <el-tab-pane label="待修改" name="2" flag="02"/>
                <el-tab-pane label="待开展" name="3" flag="03"/>
                <el-tab-pane label="开展中" name="4" flag="04"/>
                <el-tab-pane label="已结束" name="5" flag="05"/>
            </el-tabs>
            <el-table :data="tableData" v-loading="loading" border class="table">
                <el-table-column label="编号" align="center" prop="code" width="60"/>
                <el-table-column label="会议日期" align="center" prop="meetingTime" width="200"/>
                <el-table-column label="医院名称" align="center" prop="hospitalName" width="200"/>
                <el-table-column label="所在省市" align="center" prop="city" width="200"/>
                <el-table-column label="课件" align="center" prop="courseware" width="200"/>
                <el-table-column label="讲者" align="center" prop="speakers" width="120"/>
                <el-table-column label="申请日期" align="center" prop="applicationTime" width="160"/>
                <el-table-column label="来源" align="center" prop="source" width="120"/>
                <el-table-column label="操作" align="center">
                    <template slot-scope="scope">
                        <el-button v-if="canInfo" type="text" icon="el-icon-info" @click="handleInfo(scope.$index, scope.row, $event)">查看</el-button>
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
        <v-info v-show="showInfo" :code="code" @back="back"></v-info>
    </div>
</template>

<script>
    import MeetingDetailApi from '../../api/meeting/meetingdetail';
    import vInfo from './meetinginfo.vue';

    export default {
        data() {
            return {
                tableData: [],
                page: {pageNo: 1, pageSize: 10},
                is_search: false,
                req: {},
                loading: false,
                initTab: "0",
                exportLoading: false,
                showInfo: false,
                showMeeting: true,
                items: [],
                code: {},
                canExport: true,
                canInfo: true
            }
        },
        components: {
            "v-info":vInfo,
        },
        //初始化
        created() {
            this.getData();
            this.canExport = this.getPerms().indexOf("meeting:detail:export")!==-1;
            this.canInfo = this.getPerms().indexOf("meeting:detail:info")!==-1;
        },
        methods: {
            back(index){
                this.showMeeting = true;
                this.showInfo = false;
                this.items.splice(index,1)
            },
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
                MeetingDetailApi.getData(this.req).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
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
                this.req = [];
                this.initTab = "0";
            },
            // 查看
            handleInfo(index,row,event){
                this.code = row.code;
                this.showMeeting = false;
                this.showInfo = true;
                this.items.push({title:event.target.innerText});
            },
            // 切换标签页
            handleClick(tab){
                this.req.flag = tab.$attrs.flag;
                this.getData();
            },
            //导出数据
            exportData(){
                this.exportLoading = true;
                MeetingDetailApi.export(this.req).then(()=>{
                    this.exportLoading = false;
                });
            }
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
