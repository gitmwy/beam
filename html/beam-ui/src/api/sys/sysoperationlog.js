import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/sys/operationlog/page/list", params);
    },
    clear: params => {
        return http.post("/sys/operationlog/clear", params)
    }
}
