<template>
    <div class="login-wrap">
        <div class="ms-login">
            <div class="ms-title">WeHeart</div>
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="0px" class="ms-content">
                <el-form-item prop="username">
                        <el-input  type="text" v-model="ruleForm.username" placeholder="用户名">
                        <el-button slot="prepend" icon="el-icon-lx-people"></el-button>
                    </el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input type="password" placeholder="密码" v-model="ruleForm.password" @keyup.enter.native="submitForm('ruleForm')">
                        <el-button slot="prepend" icon="el-icon-lx-lock"></el-button>
                    </el-input>
                </el-form-item>
                <el-form-item>
<!--                    <el-col :span="12">-->
<!--                        <el-input  type="test" placeholder="验证码" v-model="ruleForm.captcha" @keyup.enter.native="submitForm('ruleForm')">-->
<!--                            <el-button slot="prepend" icon="el-icon-lx-warn"></el-button>-->
<!--                        </el-input>-->
<!--                    </el-col>-->
<!--                    <el-col :span="12">-->
<!--                        <img :src="ruleForm.src" @click="refreshCaptcha" alt="加载失败" style="float: right"/>-->
<!--                    </el-col>-->
                    <Slider :confirm-words="confirmWords" ref="slider"/>
                </el-form-item>
                <div class="login-btn">
                    <el-button type="primary" v-loading="loading" @click="submitForm('ruleForm')">登录</el-button>
                </div>
            </el-form>
        </div>
    </div>
</template>

<script>
    import loginApi from '../../api/page/login';
    import Slider from "../common/Slider";

    export default {
        components: {Slider},
        data() {
            return {
                loading: false,
                ruleForm: {
                    username: 'admin',
                    password: '123456',
                    // captcha: '',
                },
                rules: {
                    username: [
                        {required: true, message: '请输入用户名', trigger: 'blur'}
                    ],
                    password: [
                        {required: true, message: '请输入密码', trigger: 'blur'}
                    ],
                    // captcha: [
                    //     {required: true, message: '请输入验证码', trigger: 'blur'}
                    // ]
                },
                confirmWords: "拖动滑块验证"
            }
        },
        // created () {
        //     this.refreshCaptcha();
        // },
        methods: {
            // refreshCaptcha() {
            //     this.ruleForm.src = "/beam_ht/captcha?t=" + new Date().getTime();
            // },
            submitForm(formName) {
                this.ruleForm.confirmSuccess = this.$refs.slider.confirmSuccess;
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.loading = true;
                        loginApi.login(this.ruleForm).then((res) => {
                            this.loading = false;
                            if (res.error === false) {
                                this.$message.success(res.msg);
                                localStorage.setItem('sysuser', JSON.stringify(res.data));
                                this.$router.push({path: '/'});
                            }
                        }, (err) => {
                            this.loading = false;
                            this.$message.error(err.msg);
                        })
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            }
        }
    }
</script>

<style scoped>
    .login-wrap {
        position: relative;
        width: 100%;
        height: 100%;
        background-image: url(../../../static/img/login.jpg);
        background-size: cover;
    }
    .ms-title {
        width: 100%;
        line-height: 50px;
        text-align: center;
        font-size: 20px;
        color: #fff;
        border-bottom: 1px solid #ddd;
    }
    .ms-login {
        position: absolute;
        left: 50%;
        top: 50%;
        width: 400px;
        margin: -190px 0 0 -225px;
        border-radius: 5px;
        background: rgba(255, 255, 255, 0.3);
        overflow: hidden;
    }
    .ms-content {
        padding: 30px 30px;
    }
    .login-btn {
        text-align: center;
    }
    .login-btn button {
        width: 100%;
        height: 36px;
        margin-bottom: 10px;
    }
</style>
