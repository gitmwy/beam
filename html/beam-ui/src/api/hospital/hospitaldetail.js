import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/hospital/detail/page/list", params)
    },
    export: (params) => {
        return http.downloadFile("/hospital/detail/export", params)
    }
}
