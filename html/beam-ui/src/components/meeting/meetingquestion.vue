<template>
    <div class="table" v-loading="canLoading">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>会议</el-breadcrumb-item>
                <el-breadcrumb-item>会议问卷</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-upload
                    v-if="canUpload"
                    style="float: left"
                    action="/beam_ht/meeting/question/upload"
                    :data="data"
                    :show-file-list="false"
                    :before-upload="beforeUpload"
                    :on-success="handleSuccess"
                    :on-error="handleError">
                    <el-button icon="el-icon-upload2" type="primary" style="float: left">上传问卷</el-button>
                </el-upload>
            </div>
            <el-table :data="tableData" v-loading="loading" class="table">
                <el-table-column label="#" align="center" prop="id" width="100"/>
                <el-table-column label="问卷" align="left" prop="questionName"/>
                <el-table-column label="次数" align="center" prop="downloadTimes" width="100"/>
                <el-table-column label="操作" align="center" prop="operation" width="180">
                    <template slot-scope="scope">
                        <el-button v-if="canDownload" type="text" class="my-icon-download" @click="handleDownload(scope.$index, scope.row)">下载</el-button>
                        <el-button v-if="canDel" type="text" icon="el-icon-delete" @click="handleDelete(scope.$index, scope.row)" >删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <!--            分页-->
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

            <!-- 删除提示框 -->
            <el-dialog title="提示" :visible.sync="delVisible" width="300px" center>
                <div class="del-dialog-cnt">删除不可恢复，是否确定删除？</div>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="delVisible = false">取 消</el-button>
                    <el-button type="primary" @click="deleteRow">确 定</el-button>
                </span>
            </el-dialog>
        </div>
    </div>
</template>

<script>
    import MeetingQuestionApi from '../../api/meeting/meetingquestion';

    export default {
        data() {
            return{
                loading: false,
                tableData: [],
                req: {},
                page: {pageNo: 1, pageSize: 10},
                data: {fileType: "question"},
                ids: [],
                canLoading: false,
                delVisible: false,
                canUpload: true,
                canDownload: true,
                canDel: true
            }
        },
        created() {
            this.getData();
            this.canUpload = this.getPerms().indexOf("meeting:question:upload")!==-1;
            this.canDownload = this.getPerms().indexOf("meeting:question:download")!==-1;
            this.canDel = this.getPerms().indexOf("meeting:question:del")!==-1;
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
                MeetingQuestionApi.getData(this.req).then((res) => {
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
            handleDelete(index, row) {
                this.ids = [row.id];
                this.delVisible = true;
            },
            handleDownload(index, row){
                this.canLoading = true;
                MeetingQuestionApi.download({id:row.id}).then(() => {
                    this.canLoading = false;
                });
            },
            reload(){
                this.getData();
            },
            handleAdd(){
                this.editVisible = true;
            },
            saveEdit(){
                this.$refs.place.validate((valid) =>{
                    if(valid){
                        this.loading = true;
                        MeetingQuestionApi.add(this.place).then((res) => {
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
                })
            },
            deleteRow() {
                MeetingQuestionApi.del(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload();
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
                this.delVisible = false;
            },
        }
    }
</script>

<style scoped>
    .handle-box {
        margin-bottom: 20px;
    }
    .handle-box >>> .el-upload--text{
        height: unset;
        border: none;
    }
    .table {
        width: 100%;
        font-size: 14px;
    }
</style>
