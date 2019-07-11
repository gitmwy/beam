<template>
    <div class="login-wrap">
        <div class="ms-login">
            <div class="ms-title">WeHeart</div>
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="0px" class="ms-content">
                <el-form-item prop="username">
                    <el-input v-model="ruleForm.username" placeholder="用户名">
                        <el-button slot="prepend" icon="el-icon-lx-people"></el-button>
                    </el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input type="password" placeholder="密码" v-model="ruleForm.password">
                        <el-button slot="prepend" icon="el-icon-lx-lock"></el-button>
                    </el-input>
                </el-form-item>
                <el-form-item prop="kaptcha">
                    <el-input type="kaptcha" placeholder="验证码" v-model="ruleForm.kaptcha"
                              @keyup.enter.native="submitForm('ruleForm')">
                        <el-button slot="prepend" icon="el-icon-lx-lock"></el-button>
                    </el-input>
                </el-form-item>
                <el-form-item>
                    <el-image :src="kaptcha" @click="refreshCode" alt="加载失败" style="float: right"/>
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

    export default {
        data: function () {
            return {
                loading: false,
                ruleForm: {
                    username: 'admin',
                    password: '123456',
                    kaptcha: ''
                },
                rules: {
                    username: [
                        {required: true, message: '请输入用户名', trigger: 'blur'}
                    ],
                    password: [
                        {required: true, message: '请输入密码', trigger: 'blur'}
                    ],
                    kaptcha: [
                        {required: true, message: '请输入验证码', trigger: 'blur'}
                    ]
                }
            }
        },
        created(){
            this.refreshCode();
        },
        methods: {
            refreshCode() {
                this.kaptcha = "/beam_ht/kaptcha/defaultKaptcha?t=" + new Date().getTime();
            },
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.loading = true;
                        loginApi.login(this.ruleForm).then((res) => {
                            this.loading = false;
                            if (res.error === false) {
                                this.$message.success(res.msg);
                                console.log(res.data);
                                localStorage.setItem('sysuser', JSON.stringify(res.data));
                                this.$router.push({path: '/'});
                            } else {
                                this.$message.error(res.msg);
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
        background-image: url(../../../static/img/login-xk.jpg);
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
        width: 350px;
        margin: -190px 0 0 -175px;
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
