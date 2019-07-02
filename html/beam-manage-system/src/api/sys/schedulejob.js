import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/sys/schedule/page/list", params);
    },
    add: params => {
        return http.post("/sys/schedule/add", params)
    },
    edit: params => {
        return http.post("/sys/schedule/edit", params)
    },
    batchDelete: ids => {
        return http.post("/sys/schedule/del", ids)
    },
    runJob: ids => {
        return http.post("/sys/schedule/run", ids)
    },
    pauseJob: ids => {
        return http.post("/sys/schedule/pause", ids)
    },
    resumeJob: ids => {
        return http.post("/sys/schedule/resume", ids)
    },
}
