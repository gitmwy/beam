import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/meeting/list/page/list", params)
    },
    export: (params) => {
        return http.downloadFile("/meeting/list/export", params)
    }
}
