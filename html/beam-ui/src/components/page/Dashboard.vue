<template>
    <div>
        <el-row :gutter="20">
            <el-col :span="8">
                <el-card shadow="hover" class="mgb20" style="height:252px;">
                    <div class="user-info">
                        <img :src="sysuser.avatar" class="user-avator" alt="">
                        <div class="user-info-cont">
                            <div class="user-info-name">{{sysuser.account}}</div>
                            <div>{{sysuser.roleNames[0]}}</div>
                        </div>
                    </div>
                    <div class="user-info-list">真实姓名：<span>{{sysuser.name}}</span></div>
                    <div class="user-info-list">所在部门：<span>{{sysuser.deptName}}</span></div>
                </el-card>
            </el-col>
        </el-row>

        <div>
            <component :is="currentRole" />
        </div>
    </div>
</template>

<script>
    import adminDashboard from './dashboards'

    export default {
        components: { adminDashboard },
        data() {
            return {
                currentRole: 'adminDashboard',
                user : null
            }
        },
        computed: {
            sysuser(){
                let sysuser = JSON.parse(localStorage.getItem('sysuser'));
                return sysuser?sysuser:this.user;
            }
        },
        created(){
            this.getDashboardContent();
        },
        methods: {
            getDashboardContent(){
                this.$api.DashboardApi.getDashboardContent().then((res)=>{
                    console.log(res);
                },(err) => {
                    this.$message.error(err.msg);
                })
            }
        }
    }
</script>

<style scoped>
    .user-info {
        display: flex;
        align-items: center;
        padding-bottom: 20px;
        border-bottom: 2px solid #ccc;
        margin-bottom: 20px;
    }

    .user-avator {
        width: 120px;
        height: 120px;
        border-radius: 50%;
    }

    .user-info-cont {
        padding-left: 50px;
        flex: 1;
        font-size: 14px;
        color: #999;
    }

    .user-info-cont div:first-child {
        font-size: 30px;
        color: #222;
    }

    .user-info-list {
        font-size: 14px;
        color: #999;
        line-height: 25px;
    }

    .user-info-list span {
        margin-left: 70px;
    }

    .mgb20 {
        margin-bottom: 20px;
    }
</style>
