export default {
    data() {
        return {
            $_sidebarElm: null
        }
    },
    mounted() {
        this.$_initResizeEvent();
        this.$_initSidebarResizeEvent()
    },
    beforeDestroy() {
        this.$_destroyResizeEvent();
        this.$_destroySidebarResizeEvent()
    },
    activated() {
        this.$_initResizeEvent();
        this.$_initSidebarResizeEvent()
    },
    deactivated() {
        this.$_destroyResizeEvent();
        this.$_destroySidebarResizeEvent()
    },
    methods: {
        debounce(func, wait, immediate) {
            let timeout, args, context, timestamp, result;

            const later = function () {
                // 据上一次触发时间间隔
                const last = +new Date() - timestamp;

                // 上次被包装函数被调用时间间隔 last 小于设定时间间隔 wait
                if (last < wait && last > 0) {
                    timeout = setTimeout(later, wait - last)
                } else {
                    timeout = null;
                    // 如果设定为immediate===true，因为开始边界已经调用过了此处无需调用
                    if (!immediate) {
                        result = func.apply(context, args);
                        if (!timeout) context = args = null
                    }
                }
            };

            return function (...args) {
                context = this;
                timestamp = +new Date();
                const callNow = immediate && !timeout;
                // 如果延时不存在，重新设定延时
                if (!timeout) timeout = setTimeout(later, wait);
                if (callNow) {
                    result = func.apply(context, args);
                    context = args = null
                }

                return result
            }
        },
        $_resizeHandler() {
            return this.debounce(() => {
                if (this.chart) {
                    this.chart.resize()
                }
            }, 100)()
        },
        $_initResizeEvent() {
            window.addEventListener('resize', this.$_resizeHandler)
        },
        $_destroyResizeEvent() {
            window.removeEventListener('resize', this.$_resizeHandler)
        },
        $_sidebarResizeHandler(e) {
            if (e.propertyName === 'width') {
                this.$_resizeHandler()
            }
        },
        $_initSidebarResizeEvent() {
            this.$_sidebarElm = document.getElementsByClassName('sidebar-container')[0]
            this.$_sidebarElm && this.$_sidebarElm.addEventListener('transitionend', this.$_sidebarResizeHandler)
        },
        $_destroySidebarResizeEvent() {
            this.$_sidebarElm && this.$_sidebarElm.removeEventListener('transitionend', this.$_sidebarResizeHandler)
        }
    }
}
