export default {
    //校验手机号
    validatePhone: (rule, value, callback) => {
        if (value === '' || value === undefined || value == null) {
            callback(new Error('请输入手机号'));
        } else if(!/^[1][3456789][0-9]{9}$/.test(value)) {
            callback(new Error('请输入正确的手机号!'));
        }else{
            callback();
        }
    },
    //校验身份证号
    validateIdNo: (rule, value, callback) => {
        if (value === '' || value === undefined || value == null) {
            callback(new Error('请输入身份证号'));
        } else if(!/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(value)) {
            callback(new Error('请输入正确的身份证号'));
        } else {
            callback();
        }
    },
    //校验邮箱
    validateEMail: (rule, value, callback) => {
        if (value === '' || value === undefined || value == null) {
            callback(new Error('请输入邮箱'));
        } else if (!/^([a-zA-Z0-9]+[-_.]?)+@[a-zA-Z0-9]+\.[a-z]+$/.test(value)) {
            callback(new Error('请输入正确的邮箱'));
        } else {
            callback();
        }
    },
    //修改递归最后一个子集为undefined
    getTreeData(data) {
        for (let i = 0; i < data.length; i++) {
            if (data[i].children.length < 1) {
                // children若为空数组，则将children设为undefined
                data[i].children = undefined;
            } else {
                // children若不为空数组，则继续 递归调用 本方法
                this.getTreeData(data[i].children);
            }
        }
        return data;
    },
}
