import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/sys/loginlog/page/list", params);
    },
    clear: params => {
        return http.post("/sys/loginlog/clear", params)
    }
}
