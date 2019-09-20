import axios from 'axios'
import {Message} from 'element-ui'

const http = {
    //下载文件
    downloadFile(url, params) {
        return axios({
            method: "get",
            url: "/beam_admin" + url,
            params: params,
            responseType: "blob"
        }).then((res) => {
            if(res.data){
                //获取文件名
                let fileName = decodeURI(res.headers['content-disposition'].split(";")[1]);
                fileName = fileName.replace(/\+/g, " ");
                // 创建blob对象
                let blob = new Blob([res.data]);
                if (window.navigator.msSaveOrOpenBlob) {
                    navigator.msSaveBlob(blob, fileName.match(/=(.*)$/)[1]);
                } else {
                    let link = document.createElement("a");
                    link.download = fileName.match(/=(.*)$/)[1];
                    // 创建一个指向该参数对象的URL
                    link.href = window.URL.createObjectURL(blob);
                    link.click();
                    //释放创建的URL
                    window.URL.revokeObjectURL(link.href);
                }
            }else {
                Message.error("下载资源失败");
            }
        }).catch((err) => {
            console.log(err);
            Message.error("下载资源失败");
        })
    },

    //get请求
    get(url, params) {
        const data = Object.assign({}, params);
        url = "/beam_admin" + url;
        return axios.get(url, {params: data}).then((res) => {
            return this.correct(res);
        }).catch((err) => {
            return this.error(err);
        })
    },

    //post请求
    post(url, data) {
        axios.defaults.headers.post['Content-Type'] = 'application/json;charset=UTF-8';
        url = "/beam_admin" + url;
        return axios.post(url, data).then((res) => {
            return this.correct(res);
        }).catch((err) => {
            return this.error(err);
        })
    },

    correct(res){
        if (res.data.error === false) {
            return Promise.resolve(res.data); //成功
        } else {
            if (res.data.code === -1) {
                localStorage.removeItem('sysuser');
                window.location = "/login";
            } else if (res.data.code === 403) {
                window.location = "/403";
            }
            Message.error(res.data.msg);
            return Promise.resolve(res.data) //拒绝
        }
    },

    error(err){
        //超时之后在这里捕抓错误信息.
        if (err.response) {
            const res = {
                code: err.response.data.code,
                msg: err.response.data.message,
            };
            return Promise.reject(res)
        } else if (err.request) {
            if (err.request.readyState === 4 && err.request.status === 0) {
                const res = {
                    code: 403,
                    msg: "网络链接错误，请刷新重试！",
                };
                Message.error(res.msg);
                return Promise.reject(res)
            }
        }
        return Promise.reject(err)
    }
};

export default http;
