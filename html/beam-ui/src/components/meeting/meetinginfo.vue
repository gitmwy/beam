<template>
    <div class="container">
        <div class="handle-box">
            <el-tag size="medium" effect="dark">S201906250001</el-tag>
            <el-tag size="medium" effect="dark" type="info" >内部系统</el-tag>
            <el-tag size="medium" effect="dark" type="warning">待审核</el-tag>
            <el-button class="el-icon-lx-forward" type="text" style="float: right" @click="onBack">返回</el-button>
        </div>
        <el-tabs v-model="initTab">
            <el-tab-pane label="会议信息" name="0" class="collapse">
                <el-collapse v-model="info">
                    <el-collapse-item title="医院信息" name="0">
                        <div>医院名称：大连市第一人民医院</div>
                        <div>所在省市：辽宁省大连市</div>
                    </el-collapse-item>
                    <el-collapse-item title="会议信息" name="1">
                        <div>会议日期：2019-01-01</div>
                        <div>会议课件：药品临床使用说明</div>
                    </el-collapse-item>
                    <el-collapse-item title="申请信息" name="2">
                        <div>申请人：李玉刚</div>
                        <div>手机号：18866668888</div>
                    </el-collapse-item>
                </el-collapse>
                <div v-show="passBtn">
                    <el-button type="danger" style="width: 10%" @click="noPass">审核不通过</el-button>
                    <el-button type="success" style="width: 10%" @click="pass">审核通过</el-button>
                </div>
                <el-dialog title="填写原因" :visible.sync="noPassVisible" width="400px" center >
                    <el-input v-model="reasons" type="textarea" :rows="6" placeholder="请输入内容"/>
                    <span slot="footer" class="dialog-footer">
                        <el-button type="primary" @click="commit">提交</el-button>
                    </span>
                </el-dialog>
            </el-tab-pane>

            <el-tab-pane label="会议现场" name="1" class="collapse">
                <el-collapse v-model="scene">
                    <el-collapse-item title="会议现场" name="0">
                        <div>实际人数：6人</div>
                        <div>实际定位：辽宁省大连市中心街道</div>
                        <div>现场视频：<br>
                            <el-row :gutter="20">
                                <el-col :span="7"><video :src="videoUrl" width="320" height="240" @click="videoShow"></video></el-col>
                            </el-row>
                        </div>
                        <div>现场照片：<br>
                            <el-row :gutter="20">
                                <el-col :span="6" v-for="url in urls" :key="url"><el-image :src="url" lazy style="width:300px;height:200px"></el-image></el-col>
                            </el-row>
                        </div>
                    </el-collapse-item>
                </el-collapse>

                <el-dialog title="会议视频 " :visible.sync="videoVisible" center>
                    <player :video-url="videoUrl" :video-type="videoType"/>
                </el-dialog>
            </el-tab-pane>

            <el-tab-pane label="会议总结" name="2" class="collapse">
                <el-collapse v-model="conclusion">
                    <el-collapse-item title="会议现场" name="0">
                        <div>劳务报销单</div>
                        <div>活动费用：270元</div>
                        <div>费用发票</div>
                    </el-collapse-item>
                </el-collapse>
            </el-tab-pane>

            <el-tab-pane label="审核记录" name="3">
                <el-table :data="tableData" v-loading="loading" border class="table">
                    <el-table-column prop="account" align="center" label="审核人员"></el-table-column>
                    <el-table-column prop="name" align="center" label="审核时间"></el-table-column>
                    <el-table-column prop="sexName" align="center" label="审核状态"></el-table-column>
                    <el-table-column prop="deptName" align="center" label="原因"></el-table-column>
                </el-table>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>

<script>
    import vDetail from './meetingdetail.vue';
    import myVideoPlayer from '../common/VideoPlayer'

    export default {
        props:{
            code: {}
        },
        data() {
            return {
                tableData: [],
                loading: false,
                initTab: "0",
                info: ["0","1","2"],
                scene: ["0"],
                conclusion: ["0"],
                noPassVisible: false,
                reasons: "",
                passBtn: true,
                videoUrl: "https://mwy-1259572200.cos.ap-beijing.myqcloud.com/2019-07-04%2009-25-04.mkv",
                videoType: "video/mp4",
                videoVisible: false,
                urls: [
                    "https://mwy-1259572200.cos.ap-beijing.myqcloud.com/50099e79-d9b6-4eaf-82fe-f912dad845ba.jpg",
                    "https://mwy-1259572200.cos.ap-beijing.myqcloud.com/bc8b8163-aeba-4360-b826-0c2bc41e86ce.jpg"
                ]
            }
        },
        components: {
            vDetail,
            "player": myVideoPlayer
        },
        methods: {
            videoShow(){
                this.videoVisible = true;
            },
            noPass(){
                this.noPassVisible = true;
            },
            pass(){
                this.passBtn = false;
            },
            commit(){
                this.noPassVisible = false;
            },
            onBack(){
                this.$emit('back');
            }
        }
    }
</script>

<style scoped>
    .collapse >>> .el-collapse-item__header{
        font-size: 15px;
        font-weight: bold;
    }
</style>
