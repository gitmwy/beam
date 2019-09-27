<template>
    <div class="container">
        <div class="handle-box">
            <el-tag size="medium" effect="dark">{{records.code}}</el-tag>
            <el-tag size="medium" effect="dark" type="info" >内部系统</el-tag>
            <el-tag size="medium" effect="dark" type="warning">{{records.status}}</el-tag>
            <el-button class="el-icon-lx-forward" type="text" style="float: right" @click="onBack">返回</el-button>
        </div>
        <el-tabs v-model="initTab" class="collapse">
            <el-tab-pane label="会议信息" name="0">
                <el-collapse v-model="info">
                    <el-collapse-item title="医院信息" name="0">
                        <div>医院名称：{{records.hospitalName}}</div>
                        <div>所在省市：{{records.hospitalAddress}}</div>
                        <div>医院等级：{{records.hospitalLevel}}</div>
                        <div>医院编号：{{records.hospitalCode}}</div>
                        <div>所属区域：{{records.hospitalArea}}</div>
                    </el-collapse-item>
                    <el-collapse-item title="会议信息" name="1">
                        <div>会议日期：{{records.meetingTime}}</div>
                        <div>会议课件：{{records.courseName}}</div>
                        <div>会议讲者：{{records.speakersName}}</div>
                        <div>劳务费用：{{records.laborCost}}</div>
                        <div>预估人数：{{records.prePersons}}</div>
                    </el-collapse-item>
                    <el-collapse-item title="申请信息" name="2">
                        <div>申请人：{{records.applicantName}}</div>
                        <div>手机号：{{records.phone}}</div>
                        <div>申请时间：{{records.applicantTime}}</div>
                        <div>活动费用：{{records.activityCost}}</div>
                        <div>审批人：{{records.auditorName}}</div>
                    </el-collapse-item>
                </el-collapse>
                <div v-show="passBtn" style="margin-top:20px">
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

            <el-tab-pane label="会议现场" name="1">
                <el-collapse v-model="scene">
                    <el-collapse-item title="会议现场" name="0">
                        <div>实际人数：{{records.realPersons}}</div>
                        <div>实际定位：{{records.address}}</div>
                        <div>现场视频：<br>
                            <el-row :gutter="20">
                                <el-col :span="7" v-for="item in records.meetingVideo" :key="item.id">
                                    <video :src="item.filePath" width="320" height="240" @click="videoShow(item.filePath)"></video>
                                </el-col>
                            </el-row>
                        </div>
                        <div>现场照片：<br>
                            <el-row :gutter="20">
                                <el-col :span="7" v-for="item in records.meetingImg" :key="item.id">
                                    <el-image :src="item.filePath" lazy style="width:320px;height:240px"></el-image>
                                </el-col>
                            </el-row>
                        </div>
                    </el-collapse-item>
                </el-collapse>

                <el-dialog title="会议视频 " :visible.sync="videoVisible" center>
                    <player :video-url="videoUrl" :video-type="videoType"/>
                </el-dialog>
            </el-tab-pane>

            <el-tab-pane label="会议总结" name="2">
                <el-collapse v-model="conclusion">
                    <el-collapse-item title="会议现场" name="0">
                        <div>劳务报销单：<br>
                            <el-row :gutter="20">
                                <el-col :span="7" v-for="item in records.laborImg" :key="item.id">
                                    <el-image :src="item.filePath" lazy style="width:300px;height:200px"></el-image>
                                </el-col>
                            </el-row>
                        </div>
                        <div>活动费用：{{records.activityCost}}</div>
                        <div>费用发票：<br>
                            <el-row :gutter="20">
                                <el-col :span="7" v-for="item in records.invoiceImg" :key="item.id">
                                    <el-image :src="item.filePath" lazy style="width:300px;height:200px"></el-image>
                                </el-col>
                            </el-row>
                        </div>
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
            meetingId: {}
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
                videoUrl: "",
                videoType: "video/mp4",
                videoVisible: false,
                records: {}
            }
        },
        watch: {
            meetingId(id) {
                this.$api.MeetingDetailApi.getInfo({meetingId:id}).then((res) => {
                    this.loading = false;
                    if (res.error === false) {
                        this.records = res.data;
                    }
                }, (err) => {
                    this.$message.error(err.msg);
                });
            }
        },
        components: {
            vDetail,
            "player": myVideoPlayer
        },
        methods: {
            videoShow(val){
                this.videoUrl = val;
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
    .collapse div{
        font-size: 14px;
        padding: 2px 0;
    }
</style>
