<template>
    <div class="table" v-loading="uploadLoading">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>会议</el-breadcrumb-item>
                <el-breadcrumb-item>会议课件</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-upload
                        v-if="canUpload"
                        style="float: left"
                        action="/beam_ht/meeting/course/ftpUpload"
                        :data="data"
                        :show-file-list="false"
                        :before-upload="beforeUpload"
                        :on-success="handleSuccess">
                    <el-button icon="el-icon-upload2" type="primary" style="float: left">上传课件</el-button>
                </el-upload>
            </div>
            <el-table :data="tableData" v-loading="loading" class="table">
                <el-table-column label="#" align="center" prop="id" width="100"/>
                <el-table-column label="课件" align="left" prop="courseName" width="700"/>
                <el-table-column label="大小" align="center" prop="courseSize" width="100"/>
                <el-table-column label="次数" align="center" prop="courseTimes" width="100"/>
                <el-table-column label="路径" align="center" prop="courseUrl" v-if="urlHidden"/>
                <el-table-column label="操作" align="center" prop="operation">
                    <template slot-scope="scope">
                        <el-tooltip effect="dark" content="下载" placement="top-start">
                            <el-button v-if="canDownload" type="text" size="medium" class="my-icon-download"/>
                        </el-tooltip>
                        <el-tooltip effect="dark" content="删除" placement="top-start">
                            <el-button v-if="canDel" type="text" size="medium" icon="el-icon-delete" @click="handleDelete(scope.$index, scope.row)" />
                        </el-tooltip>
                    </template>
                </el-table-column>
            </el-table>
            <!--            分页-->
            <div class="pagination">
                <el-pagination
                    background
                    :page-sizes="[5, 10, 20, 30, 40]"
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
    import MeetingCourseApi from '../../api/meeting/meetingcourse';

    export default {
        data() {
            return{
                number: 0,
                loading: false,
                tableData: [],
                req: {},
                page: {pageNo: 1, pageSize: 5},
                data: {fileType: "img"},
                ids: [],
                urlHidden: false,
                uploadLoading: false,
                delVisible: false,
                canUpload: true,
                canDownload: true,
                canDel: true
            }
        },
        created() {
            this.getData();
            this.canUpload = this.getPerms().indexOf("meeting:course:ftpUpload")!==-1;
            this.canDownload = this.getPerms().indexOf("meeting:course:download")!==-1;
            this.canDel = this.getPerms().indexOf("meeting:course:del")!==-1;
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
                MeetingCourseApi.getData(this.req).then((res) => {
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
            beforeUpload(){
                this.uploadLoading = true;
            },
            handleSuccess(res){
                if (res.error) {
                    this.$message.error(res.msg);
                } else {
                    this.getData();
                }
                this.uploadLoading = false;
            },
            handleDelete(index, row) {
                // this.ids.push(row);
                // this.ids = JSON.stringify(this.ids);// 后台list接收
                this.ids = row;
                this.delVisible = true;
            },
            deleteRow() {
                MeetingCourseApi.del(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload()
                    } else {
                        this.$message.error(res.msg);
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
    .handle-box >>> .el-upload--text{
        height: unset;
        border: none;
    }
    .table {
        width: 100%;
        font-size: 14px;
    }
</style>
