import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/meeting/detail/page/list", params)
    },
    export: (params) => {
        return http.downloadFile("/meeting/detail/export", params)
    }
}
