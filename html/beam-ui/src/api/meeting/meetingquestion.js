import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/meeting/question/page/list", params)
    },
    del: params =>{
        return http.post("/meeting/question/del", params)
    },
    download: (params) => {
        return http.downloadFile("/meeting/question/download", params)
    }
}
