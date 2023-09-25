<html lang="en">
<link rel="shortcut icon" type="image/png" href="static/images/favicon.ico"/>

<head>
    <script src="https://code.jquery.com/jquery-3.5.0.min.js"integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ="crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Twitter login</title>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');

    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    body{
        display: flex;
        justify-content: center;
    }

    .container{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin: 5rem 0;
        padding: 1%;
        border-radius: 12px;
        background: #ffffff;
        box-shadow:  14px 14px 30px #cccccc,
                 -14px -14px 24px #ffffff;
    }

    .button{
        display: flex;
        align-items:center;
        border: 1px gray solid;
        border-radius: 24px;
        background-color: white;
        padding: .5rem 4rem;
        margin: 1rem 0;
    }

    .button:hover{
        background-color: #f5f5f5;
        cursor: pointer;
    }

    .button .img{
        padding-right: 1rem;
    }

    .button p{
        font-weight: bolder;
    }

    .img{
        max-width: 40px;
        max-height: 40px;
    }

    .form{
        margin: 1rem 0;
        display: flex;
        flex-direction: column;
    }

    input{
        margin: .8rem;
    }

    input[type="text"]{
        border: 1px gray solid;
        border-radius: 4px;
        padding: .4rem 4rem;
    }

    input[type="text"]:focus{
        outline: none;
        border: 1px solid #1d9bf0;
        cursor: pointer;
    }

    #next{
        background-color: black;
        color: white;
        border: 1px black solid;
        border-radius: 24px;
        padding: .5rem 4rem;
        font-weight: bold;
    }

    #next:hover{
        cursor: pointer;
    }

    #forgot{
        background-color: white;
        border: 1px gray solid;
        border-radius: 24px;
        padding: .5rem 4rem;
    }

    #forgot:hover{
        background-color: #f5f5f5;
        cursor: pointer;
    }

    #signup{
        color: gray;
        font-size: 14px;
    }

    #signup a{
        color: #1d9bf0;
        text-decoration: none;
    }

    </style>
</head>
<body>
    <div class="container">
        <img src="https://img.icons8.com/color/48/undefined/twitter--v1.png" alt="twitter logo" class="img">
        <h1>Login your account</h1>
        <form class="form">
            <input id="signup-email" type="email" placeholder="                          Fill your email"" size="40">
            <input id="signup-password" type="password" placeholder="                     Fill your password" size="40">
            <p style="color:red; display:none" id="signup-error"></p>
            <input id="next" type="submit" value="Login">
            <input id="forgot" type="submit" value="Forgot Password ?">
        </form>
        <p id="signup">Don't have an account ? <a href="#">Sign up</a></p>
    </div>
    <script>
    function validateSignupForm(){
        var email = $("#signup-email").val();
        var password = $("#signup-password").val();
        var error = "";
        if(!email){
        error+="Email is empty.";
         }
         if(!password){
         error+="Password is empty.";
         }
         if(password.length<3){
         error+="Password length must be greater than 3 characters.";
    }
    $("#signup-error").html(error);
    if(error.length>0){
    return false;
    }

    return true;
    }
    $("#next").click(function(){
      var isFormValid = validateSignupForm();
      if(isFormValid){
          $("#signup_error").hide();
          var email = $("#signup-email").val();
          var password = $("#signup-password").val();
          var user={
            "email" : email,
            "password" : password
            };
          $.ajax({
          type: "POST",
          url: "/login/welcome",
          data: JSON.stringify(user),
          success: function(response){
          if(!!response){
          if(response.is_logined===true){
            location.href="/user/welcome";
          }
          else{
          $("#signup-password").val("");
          $("#signup-error").html(response.message);
          $("#signup-error").show();

          }
          }
          },
          contentType: "application/json"
          });
      }
      else{
              $("#signup-error").show();
              }
           }
);
    </script>
</body>
</html>