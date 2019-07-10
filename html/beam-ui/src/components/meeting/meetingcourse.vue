<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>会议</el-breadcrumb-item>
                <el-breadcrumb-item>会议课件</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-upload style="float: left"
                           action="/beam_ht/file/ftpUpload"
                           :data="data"
                           :on-preview="handlePreview"
                           :on-remove="handleRemove"
                           :before-remove="beforeRemove">
                    <el-button icon="el-icon-upload2" type="primary">上传课件</el-button>
                </el-upload>
            </div>
            <el-table :data="tableData" v-loading="loading" class="table">
                <el-table-column label="#" align="center" prop="code" width="100"/>
                <el-table-column label="课件" align="left" prop="course" width="700"/>
                <el-table-column label="大小" align="center" prop="size" width="100"/>
                <el-table-column label="次数" align="center" prop="times" width="100"/>
                <el-table-column label="操作" align="center" prop="operation">
                    <template slot-scope="scope">
                        <el-button type="text" icon="el-icon-download"/>
                        <el-button type="text" icon="el-icon-delete"/>
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
    </div>
</template>

<script>
    import MeetingCourseApi from '../../api/meeting/meetinglist';

    export default {
        data() {
            return{
                number: 0,
                loading: false,
                tableData: [],
                page: {pageNo: 1, pageSize: 10},
                data: {
                    fileType: "img"
                }
            }
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
            handleRemove(file, fileList) {
                console.log(file, fileList);
            },
            handlePreview(file) {
                console.log(file);
            },
            beforeRemove(file) {
                return this.$confirm(`确定移除 ${ file.name }？`);
            }
        }

    }
</script>

<style scoped>
    .handle-box >>> .el-upload--text{
        width: unset;
        height: unset;
        border: none;
    }
    .table {
        width: 100%;
        font-size: 14px;
    }
</style>
