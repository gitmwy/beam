import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/meeting/course/page/list", params)
    }
}
