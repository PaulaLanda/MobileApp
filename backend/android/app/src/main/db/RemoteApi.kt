package db

import com.google.gson.JsonObject
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Query


interface RemoteAPI {
    @GET("/")
    suspend fun get():JsonObject

    @POST("/")
    suspend fun submit(@Query("order") s: String):String
}

object HelperClass {
    fun getInstance(): RemoteAPI {

        val mRemoteCloudService =
            Retrofit.Builder().baseUrl("https://mariagtlv.pythonanywhere.com/")
                .addConverterFactory(GsonConverterFactory.create())
                .build().create(RemoteAPI::class.java)


        return mRemoteCloudService
    }
}