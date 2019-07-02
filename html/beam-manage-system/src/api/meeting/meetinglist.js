import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/meetinglist/page/list", params)
    },
    export: (params, fileName) => {
        return http.export("/meetinglist/export", params, fileName)
    }
}
