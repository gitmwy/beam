import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/meeting/place/page/list", params)
    },
    del: params =>{
        return http.post("/meeting/place/del", params)
    },
    add: params => {
        return http.post("/meeting/place/add", params)
    },
}
