<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>会议</el-breadcrumb-item>
                <el-breadcrumb-item>会议场所</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-button v-if="canAdd" type="primary" icon="add" @click="handleAdd">新增场所</el-button>
            </div>
            <el-table :data="tableData" v-loading="loading" class="table">
                <el-table-column label="#" align="center" prop="id" width="100"/>
                <el-table-column label="类型名称" align="center" prop="typeName"/>
                <el-table-column label="场所" align="center" prop="place"/>
                <el-table-column label="操作" align="center" width="180">
                    <template slot-scope="scope">
                        <el-tooltip effect="dark" content="删除" placement="right">
                            <el-button v-if="canDel" type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)" >删除</el-button>
                        </el-tooltip>
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
        </div>

        <!-- 编辑弹出框 -->
        <el-dialog title="编辑" :visible.sync="editVisible" width="50%" @close="handleClose">
            <el-form ref="place" :model="place" :rules="rules" label-width="100px">
                <el-form-item label="类型" prop="typeId">
                    <el-select v-model.trim="place.typeId" placeholder="请选择类型">
                        <el-option v-for="item in typeList" :key="item.id" :label="item.typeName" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="场所" prop="place">
                    <el-input v-model.trim="place.place" placeholder="请输入场所"></el-input>
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
            return{
                loading: false,
                tableData: [],
                req: {},
                typeList: [],
                page: {pageNo: 1, pageSize: 10},
                ids: [],
                place: {},
                rules: {
                    typeId: [
                        {required: true, message: '请选择类型', trigger: 'change'},
                    ],
                    place: [
                        {required: true, message: '请输入场所', trigger: 'blur'},
                    ],
                },
                editVisible: false,
                canAdd: true,
                canDel: true
            }
        },
        created() {
            this.getTypeList();
            this.getData();
            this.canAdd = this.$tools.getPerms().indexOf("meeting:place:add")!==-1;
            this.canDel = this.$tools.getPerms().indexOf("meeting:place:del")!==-1;
        },
        methods: {
            getTypeList(){
                this.$api.MeetingPlaceApi.getTypeList().then((res) => {
                    if (res.error === false) {
                        this.typeList = res.data;
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
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
                this.$api.MeetingPlaceApi.getData(this.req).then((res) => {
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
            handleDelete(index, row) {
                this.ids = [row.id];
                this.$tools.messageBox('删除不可恢复，是否确定删除？', this.deleteRow);
            },
            reload(){
                this.getData();
            },
            handleAdd(){
                this.editVisible = true;
            },
            handleClose(){
                this.place = {};
                this.$refs.place.clearValidate();
            },
            saveEdit(){
                this.$refs.place.validate((valid) =>{
                    if(valid){
                        this.loading = true;
                        this.$api.MeetingPlaceApi.add(this.place).then((res) => {
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
                this.$api.MeetingPlaceApi.del(this.ids).then((res) => {
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
    .red {
        color: #ff0000;
    }
</style>
