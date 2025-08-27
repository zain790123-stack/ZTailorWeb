<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ZTailor Craft</title>
    <link rel="stylesheet" href="css/styl.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
    <link rel="icon" type="image/x-icon" href="images/fav.png">
    <style >
    * {
     margin: 0;
     padding: 0;
     box-sizing: border-box;
      }

     body {
     height: 100%;
     font-family: Arial, sans-serif;
          }
     .landing_page {
      width: 100%;
      height: 100%;
      background: linear-gradient(to bottom, #1b1b1b, #121212);
      }
      .navbar {
      background-color: #1b1b1b;
      padding: 10px 20px;
      display: flex;
      justify-content: center;
      }
       .navbar a {
       color: white;
       text-decoration: none;
       margin-left: 15px;
       font-size: 1.1em;
       padding: 10px 15px;
       border-radius: 5px;
       transition: background-color 0.3s;
       }
       .navbar a:hover {
        background-color: #ff6347;
        }
       .content {
        position: relative;
        z-index: 10;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        color: #fff;
        padding: 20px;
        height:600px;
         }
        .header {
         font-family: 'Great Vibes', cursive;
         font-size: 4em;
         color: #ff6347;
         }
        .subheader {
        font-family: 'Poppins', sans-serif;
        font-size: 1.7em;
        font-weight: 300;
        color: #dcdcdc;
        margin-top: 10px;
        }
        .cta-button {
        background-color: #ff6347;
        padding: 15px 30px;
        margin-top: 20px;
        font-size: 1.2em;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-decoration: none;
        transition: transform 0.3s, box-shadow 0.3s;
        }
        .cta-button:hover {
        transform: scale(1.1);
        box-shadow: 0 4px 8px rgba(255, 99, 71, 0.4);
        }
        
        footer {
          background-color: #222;
          color: #f9f9f9;
          padding: 40px 20px;
          text-align: center;
           } 

          footer .footer-content {
          margin-bottom: 20px;
          }

          footer .footer-content h3 {
          font-size: 1.8em;
           margin-bottom: 10px;
           color: #d1c8c4;
           }

          footer .footer-content p {
          font-size: 1em;
          margin-bottom: 20px;
          color: #bbb;
           }

          footer .footer-content .socials {
           list-style: none;
           padding: 0;
           display: flex;
           justify-content: center;
           gap: 15px;
            }

          footer .footer-content .socials li {
          display: inline-block;
          }

          footer .footer-content .socials li a {
          font-size: 1.5em;
          color: #f9f9f9;
          transition: color 0.3s ease;
          }

          footer .footer-content .socials li a:hover {
          color: #ff4500;
          }

          footer .footer-bottom {
           border-top: 1px solid #444;
           padding-top: 10px;
           margin-top: 20px;
            }

            footer .footer-bottom p {
            font-size: 0.9em;
             color: #bbb;
             margin: 0;
             }
             
        
           @media (max-width: 480px) {
            .navbar {
            flex-direction: column;
            align-items: center;
            padding: 10px;
            }

  .navbar a {
    margin: 8px 0;
    font-size: 1em;
    padding: 8px 12px;
  }

  .content {
    padding: 20px 10px;
    height: auto;
  }

  .header {
    font-size: 2.5em;
  }

  .subheader {
    font-size: 1.2em;
  }

  .cta-button {
    padding: 12px 24px;
    font-size: 1em;
  }

  footer .footer-content h3 {
    font-size: 1.5em;
  }

  footer .footer-content p {
    font-size: 0.9em;
  }

  footer .footer-content .socials li a {
    font-size: 1.2em;
  }
}


@media (max-width: 768px) {
  .navbar {
    flex-wrap: wrap;
    justify-content: center;
    gap: 10px;
  }

  .navbar a {
    font-size: 1em;
    padding: 10px;
  }

  .content {
    padding: 30px 15px;
    height: auto;
  }

  .header {
    font-size: 3em;
  }

  .subheader {
    font-size: 1.4em;
  }

  .cta-button {
    padding: 14px 28px;
    font-size: 1.1em;
  }

  footer .footer-content h3 {
    font-size: 1.6em;
  }

  footer .footer-content p {
    font-size: 1em;
  }
}


@media (max-width: 1024px) {
  .navbar {
    padding: 10px 15px;
  }

  .navbar a {
    font-size: 1.05em;
  }

  .header {
    font-size: 3.5em;
  }

  .subheader {
    font-size: 1.5em;
  }

  .cta-button {
    padding: 15px 30px;
    font-size: 1.1em;
  }
}
             

           </style>
</head>
<body>
    <div class="container">
    <div class="landing_page">
    <div class="navbar">
       <a href="unifiedLogin.jsp">Login</a>
       <a href="signup.jsp">Sign Up</a>
       <a href="affilate tailors.jsp">Affilate Tailor</a>
       <a href="CheckRequestStatus.jsp">Check Request Status</a>
    </div>
  
    <div class="content">
      <h1 class="header">ZTailor Craft</h1>
      <p class="subheader">A brand for style and quality</p>
      <a href="about_us.html" class="cta-button">More About Us</a>
    </div>
      
<footer>
    <div class="footer-content">
        <h3>Tailoring Service</h3>
        <p>We provide Best tailoring services to bring out your best style.</p>
        <ul class="socials">
            <li><a href="https://www.facebook.com/"><i class="fa-brands fa-facebook"></i></a></li>
            <li><a href="https://x.com/"><i class="fab fa-x"></i></a></li>
            <li><a href="https://www.instagram.com/"><i class="fab fa-instagram"></i></a></li>
            <li><a href="https://www.youtube.com/"><i class="fab fa-youtube"></i></a></li>
            <li><a href="https://www.whatsapp.com/"><i class="fab fa-whatsapp"></i></a></li>
        </ul>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2025 ZTailor Craft | All Rights Reserved</p>
    </div>
</footer>
    </div>
    </div>
</body>
</html>