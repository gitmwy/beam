import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/sys/dict/page/list", params);
    },
    add: params => {
        return http.post("/sys/dict/add", params)
    },
    batchDelete: ids => {
        return http.post("/sys/dict/del", ids)
    },
    getDictList: params => {
        return http.get("/sys/dict/list", params);
    },
}
