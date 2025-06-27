package com.toniminarro.twinsforandroid

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.toniminarro.twinsforandroid.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.textView.text = getString(R.string.hello_world)
    }
}
