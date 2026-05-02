import axios, { AxiosError, AxiosInstance, AxiosRequestConfig } from 'axios'

const request: AxiosInstance = axios.create({
  baseURL: '/api/v1',
  timeout: 30000,
})

request.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('access_token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => Promise.reject(error),
)

request.interceptors.response.use(
  (response) => {
    const data = response.data
    if (data.code !== 200) {
      return Promise.reject(new Error(data.message || '请求失败'))
    }
    return data.data
  },
  (error: AxiosError<{ message: string }>) => {
    const message = error.response?.data?.message || error.message || '网络错误'
    if (error.response?.status === 401) {
      localStorage.removeItem('access_token')
      localStorage.removeItem('refresh_token')
      window.location.href = '/login'
    }
    return Promise.reject(new Error(message))
  },
)

export default request
