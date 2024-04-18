import axios, { InternalAxiosRequestConfig } from '@ohos/axios'
import { AxiosInstance, AxiosResponse } from '@ohos/axios'
import router from '@ohos.router'
import { BASE_URL } from '../common/Config'
import promptAction from '@ohos.promptAction'

const baseRequest: AxiosInstance = axios.create({
  baseURL: BASE_URL,
  timeout: 60000
})

const requestInterceptors = [
  (config: InternalAxiosRequestConfig) => {
    config.headers.token = ''
    return config
  },
  (err: any) => {
    return Promise.reject(err)
  }
]

const responseInterceptors = [
  (res: AxiosResponse) => {
    if(res.data.return_code != 20000) {
      // console.log('testTag', 'response', JSON.stringify(res))
      promptAction.showToast({message: res.data.message})
      return Promise.reject(res.data)
    }else {
      return res.data
    }
  },
  (err: any) => {
    // console.log('testTag', 'error', JSON.stringify(err))
    if(err.response?.status === 401) {
      // 清除token
      router.replaceUrl({
        url: 'page/Login'
      })
    }
    return Promise.reject(err)
  }
]

baseRequest.interceptors.request.use(...requestInterceptors)
baseRequest.interceptors.response.use(...responseInterceptors)

export {
  baseRequest
}