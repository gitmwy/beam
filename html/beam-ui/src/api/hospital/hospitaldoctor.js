import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/hospital/doctor/page/list", params)
    },
    export: (params) => {
        return http.downloadFile("/hospital/doctor/export", params)
    }
}
