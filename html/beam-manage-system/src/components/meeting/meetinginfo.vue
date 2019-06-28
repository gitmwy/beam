<template>
    <div class="container">
        <div class="handle-box">
            <el-tag>S201906250001</el-tag>
            <el-tag type="info">内部系统</el-tag>
            <el-tag type="warning">待审核</el-tag>
            <el-button class="el-icon-lx-forward" type="text" style="float: right" @click="onBack">返回</el-button>
        </div>
        <el-tabs v-model="initTab">
            <el-tab-pane label="会议信息" name="0"/>
            <el-tab-pane label="会议现场" name="1"/>
            <el-tab-pane label="会议总结" name="2"/>
        </el-tabs>
        <div class="collapse">
            <el-collapse v-model="meetingInfo">
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
        </div>
    </div>
</template>

<script>
    import vMeeting from './meetinglist.vue';

    export default {
        props:{
            code: {}
        },
        data() {
            return {
                initTab: "0",
                meetingInfo: ["0","1","2"]
            }
        },
        components: {
            vMeeting
        },
        methods: {
            onBack(){
                this.$emit('back');
                this.$emit('remove');
            }
        }
    }
</script>

<style scoped>
    .handle-box {
        margin-bottom: 20px;
    }
    .collapse >>> .el-collapse-item__header{
        font-size: 15px;
        font-weight: bold;
    }
</style>
