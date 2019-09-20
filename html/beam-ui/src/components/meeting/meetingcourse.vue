<template>
    <div class="table" v-loading="canLoading">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>会议</el-breadcrumb-item>
                <el-breadcrumb-item>会议课件</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-row type="flex" align="middle" class="handle-row-upload">
                    <el-col :span="12">统计：{{total}}</el-col>
                    <el-col :span="12">
                        <el-upload
                                v-if="canUpload"
                                style="float: right"
                                action="/beam_admin/meeting/course/upload"
                                :data="data"
                                :show-file-list="false"
                                :before-upload="beforeUpload"
                                :on-success="handleSuccess"
                                :on-error="handleError">
                            <el-button icon="el-icon-upload2" type="text" size="medium">上传课件</el-button>
                        </el-upload>
                    </el-col>
                </el-row>
            </div>
            <el-table :data="tableData" v-loading="loading" class="table">
                <el-table-column label="#" align="center" prop="id" width="100"/>
                <el-table-column label="课件" align="left" prop="courseName" width="700"/>
                <el-table-column label="大小" align="center" prop="fileSize" width="100"/>
                <el-table-column label="次数" align="center" prop="downloadTimes" width="100"/>
                <el-table-column label="操作" align="center" prop="operation">
                    <template slot-scope="scope">
                        <el-button v-if="canDownload" type="text" class="my-icon-download" @click="handleDownload(scope.$index, scope.row)">下载</el-button>
                        <el-button v-if="canDel" type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)" >删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <!-- 分页-->
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
            return{
                loading: false,
                tableData: [],
                req: {},
                page: {pageNo: 1, pageSize: 10},
                data: {fileType: "course"},
                ids: [],
                total: 0,
                canLoading: false,
                canUpload: true,
                canDownload: true,
                canDel: true,
            }
        },
        created() {
            this.getData();
            this.canUpload = this.$tools.getPerms().indexOf("meeting:course:upload")!==-1;
            this.canDownload = this.$tools.getPerms().indexOf("meeting:course:download")!==-1;
            this.canDel = this.$tools.getPerms().indexOf("meeting:course:del")!==-1;
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
                this.$api.MeetingCourseApi.getData(this.req).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
                        this.total = res.data.total;
                        this.tableData = res.data.records ? res.data.records : [];
                        this.page.pageNo = parseInt(res.data.current);
                        this.page.totalRows = parseInt(res.data.total);
                    }
                }, (err) => {
                    this.loading = false;
                    this.$message.error(err.msg);
                });
            },
            beforeUpload(){
                this.canLoading = true;
            },
            handleSuccess(res){
                if (res.error === false) {
                    this.$message.success(res.msg);
                    this.reload();
                }
                this.canLoading = false;
            },
            handleError(){
                this.$message.error("上传课件失败，请稍后再试");
                this.canLoading = false;
            },
            handleDownload(index, row){
                this.canLoading = true;
                this.$api. MeetingCourseApi.download({id:row.id}).then(() => {
                    this.canLoading = false;
                });
            },
            reload(){
                this.getData();
            },
            handleDelete(index, row) {
                this.ids = [row.id];
                this.$tools.messageBox('删除不可恢复，是否确定删除？', this.deleteRow);
            },
            deleteRow() {
                this.$api.MeetingCourseApi.del(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload();
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
        }
    }
</script>

<style scoped>
    .handle-box >>> .el-upload{
        display: unset;
    }
    .red {
     color: #ff0000;
    }
</style>
