import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/meeting/list/page/list", params)
    },
    export: (params, fileName) => {
        return http.export("/meeting/list/export", params, fileName)
    }
}
