import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/meeting/detail/page/list", params)
    },
    getInfo: params => {
        return http.get("/meeting/detail/info", params)
    },
    auditor: (params) => {
        return http.post("/meeting/detail/auditor", params)
    },
    export: (params) => {
        return http.downloadFile("/meeting/detail/export", params)
    }
}
