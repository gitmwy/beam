<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>用户</el-breadcrumb-item>
                <el-breadcrumb-item>区域管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-select v-model="req.level" placeholder="请选择等级">
                    <el-option v-for="item in levelList" :key="item.id" :label="item.paramValue" :value="item.paramKey"></el-option>
                </el-select>
                <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
                <el-button type="primary" icon="el-icon-refresh" @click="refresh">重置</el-button>
                <el-button v-if="canAdd" type="primary" icon="add" @click="handleAdd">新增区域</el-button>
            </div>
            <el-table row-key="id" :data="treeData" v-loading="loading" border class="table">
                <el-table-column label="区域名称" align="center" prop="areaName" width="300"/>
                <el-table-column label="等级" align="center" prop="levelName" width="100"/>
                <el-table-column label="关联" align="center" prop="optionAreas"/>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button v-if="canEdit" type="text" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row, $event)">编辑</el-button>
                        <el-button v-if="canDel" type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>

        <!-- 编辑弹出框 -->
        <el-dialog title="编辑" :visible.sync="editVisible" width="50%" @close="handleClose">
            <el-form ref="area" :model="area" :rules="rules" label-width="100px">
                <el-form-item label="区域等级" prop="levelName">
                    <el-select v-model.trim="area.levelName" placeholder="请选择等级" @change="goToSelectLevel">
                        <el-option v-for="item in levelList" :key="item.id" :label="item.paramValue" :value="`${item.paramKey}|${item.paramValue}`"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="区域名称" prop="areaName">
                    <el-input v-model.trim="area.areaName" placeholder="请输入自定义名称"></el-input>
                </el-form-item>
                <div class="cascader">
                    <el-form-item label="关联区域">
                        <el-cascader
                            clearable
                            ref="cascaderAddr"
                            v-model.trim="area.parentId"
                            :options="areaItems"
                            :props="defaultProps"
                            placeholder="请选择所属区域"
                            @focus="handleFocus"
                            @change="getAreaData">
                        </el-cascader>
                    </el-form-item>
                </div>
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
            return {
                areaItems: [],
                treeData: [],
                editVisible: false,
                req: {},
                area: {},
                levelList: [],
                ids: [],
                defaultProps: {
                    children: 'children',
                    label: 'areaName',
                    value: 'id',
                    emitPath: false
                },
                rules: {
                    levelName: [
                        {required: true, message: '请选择区域等级', trigger: 'blur'},
                    ],
                    areaName: [
                        {required: true, message: '请输入区域名称', trigger: 'blur'},
                    ]
                },
                loading: false,
                canAdd: true,
                canEdit: true,
                canDel: true
            }
        },
        //初始化
        created() {
            this.getAreaLevel();
            this.getTreeData();
            this.canAdd = this.$tools.getPerms().indexOf("user:area:add")!==-1;
            this.canEdit = this.$tools.getPerms().indexOf("user:area:edit")!==-1;
            this.canDel = this.$tools.getPerms().indexOf("user:area:del")!==-1;
        },
        methods: {
            getAreaLevel(){
                this.$api.UserConfigApi.getAreaLevel().then((res) => {
                    if (res.error === false) {
                        this.levelList = res.data;
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            //获取表格数据
            getTreeData() {
                this.loading = true;
                this.$api.UserAreaApi.getTreeData(this.req).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
                        this.treeData = res.data;
                    }
                }, (err) => {
                    this.loading = false;
                    this.$message.error(err.msg);
                });
            },
            // 搜索
            search() {
                this.getTreeData();
            },
            // 重置查询条件
            refresh() {
                this.req = [];
            },
            handleClose(){
                this.areaItems = [];
                this.area = {};
                this.$refs.area.clearValidate();
            },
            handleAdd(){
                this.editVisible = true;
            },
            handleEdit(index, row){
                this.$api.UserAreaApi.edit({areaId:row.id}).then((res) => {
                    if (res.error === false) {
                        this.area = res.data;
                        this.getOptionArea(this.area.level);
                        this.editVisible=true;
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            goToSelectLevel(data){
                let [id, name] = data.split("|");
                this.area.level = id;
                this.area.levelName = name;
                this.area.parentId = null;
                this.area.optionAreas = null;
                this.getOptionArea(id);
            },
            getOptionArea(id){
                this.$api.UserAreaApi.options({level:id}).then((res) => {
                    if (res.error === false) {
                        this.areaItems = this.$tools.getTreeData(res.data);
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            },
            handleFocus(){
                if(null == this.area.levelName){
                    this.$message.error("请先选择区域等级");
                }
            },
            getAreaData(){
                let node = this.$refs.cascaderAddr.getCheckedNodes()[0];
                if(null != node){
                    this.area.optionAreas = (node.data.optionAreas + "/" + node.data.areaName).replace(/^\//,'');
                }
            },
            saveEdit(){
                this.$refs.area.validate((valid) =>{
                    if(valid){
                        this.loading = true;
                        this.$api.UserAreaApi.add(this.area).then((res) => {
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
            reload() {
                this.getAreaLevel();
                this.getTreeData();
            },
            handleDelete(index, row) {
                this.ids = [row.id];
                this.$tools.messageBox('删除不可恢复，是否确定删除？', this.deleteRow);
            },
            deleteRow(){
                this.$api.UserAreaApi.batchDelete(this.ids).then((res) => {
                    if (res.error === false) {
                        this.$message.success(res.msg);
                        this.reload();
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            }
        }
    }
</script>

<style scoped>
    .cascader .el-cascader{
        width: 100%;
    }
    .red {
        color: #ff0000;
    }
</style>
