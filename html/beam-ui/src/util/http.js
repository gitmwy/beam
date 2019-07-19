import axios from 'axios'
import {commonParams} from './config'
import {Message} from 'element-ui'

const Http = {
    //下载文件
    downloadFile(url, params) {
        return axios({
            method: "get",
            url: "/beam_ht" + url,
            params: params,
            responseType: "blob"
        }).then((res) => {
            if(res.data){
                //获取文件名
                let fileName = decodeURI(res.headers['content-disposition'].split(";")[1]);
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
        }).catch(() => {
            Message.error("下载资源失败");
        })
    },

    //get请求
    get(url, params) {
        const data = Object.assign({}, commonParams, params);
        url = "/beam_ht" + url;
        return axios.get(url, {params: data}).then((res) => {
            return this.result(res);
        }).catch((err) => {
            return this.error(err);
        })
    },

    //post请求
    post(url, data) {
        axios.defaults.headers.post['Content-Type'] = 'application/json;charset=UTF-8';
        url = "/beam_ht" + url;
        return axios.post(url, data).then((res) => {
            return this.result(res);
        }).catch((err) => {
            return this.error(err);
        })
    },

    result(res){
        if (res.data.error === false) {
            return Promise.resolve(res.data); //成功
        } else {
            if (res.data.code === -1) {
                Message.error(res.data.msg);
                window.location = "/#/login";
                return Promise.resolve(res) //拒绝
            } else if (res.data.code === 403) {
                Message.error(res.data.msg);
                window.location = "/#/403";
                return Promise.resolve(res) //拒绝
            } else {
                Message.error(res.data.msg);
                return Promise.resolve(res) //拒绝
            }
        }
    },

    error(err){
        //超时之后在这里捕抓错误信息.
        if (err.response) {
            var res = {
                code: err.code,
                msg: err.message,
            };
            return Promise.reject(res)
        } else if (err.request) {
            if (err.request.readyState === 4 && err.request.status === 0) {
                var res = {
                    code: 403,
                    msg: "网络链接错误，请刷新重试！",
                };
                Message.error("网络链接错误，请刷新重试！");
                return Promise.reject(res)
            }
        } else {
            Message.error(err.message);
            return Promise.reject(res)
        }
        return Promise.reject(err)
    }
};

export default Http;
