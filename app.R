library(shiny)
library(bslib)

# -------------------------------
# არქეტიპები
# -------------------------------
archetypes <- c("zeus","athena","ares","aphrodite","artemis","poseidon")

titles <- c(
  zeus = "⚡ ზევსი",
  athena = "🧠 ათენა",
  ares = "🔥 არესი",
  aphrodite = "💖 აფროდიტე",
  artemis = "🌙 არტემიდა",
  poseidon = "🌊 პოსეიდონი"
)

descriptions <- c(
  zeus = "შენ ხარ ლიდერი, რომელსაც ბუნებრივად აქვს ძალაუფლების აღების უნარი. გიყვარს კონტროლი, პასუხისმგებლობა და გავლენა. ადამიანები ხშირად შენში ხედავენ ავტორიტეტს. შენი გამოწვევა არის ის, რომ არ გახდე ზედმეტად დომინანტი და ისწავლო სხვების მოსმენაც.",
  
  athena = "შენ ხარ სტრატეგი და გონებრივი ძალის მატარებელი. გადაწყვეტილებებს იღებ ანალიზით და წინასწარი გათვლით. გიყვარს ცოდნა, სიზუსტე და გონივრული მიდგომა. შენი გამოწვევა არის ზედმეტი გადაფიქრება და ემოციების იგნორირება.",
  
  ares = "შენ ხარ მოქმედების ადამიანი. ენერგია, იმპულსი და სიმამაცე შენი მთავარი ძალებია. არ გეშინია რისკის და ხშირად ხარ პირველი, ვინც იწყებს მოქმედებას. შენი გამოწვევა არის მოთმინება და კონფლიქტების მართვა.",
  
  aphrodite = "შენ ხარ ემოციური და ურთიერთობებზე ორიენტირებული. გიყვარს სილამაზე, სიყვარული და კავშირი ადამიანებთან. შენი ძალა არის გრძნობების გამოხატვა. შენი გამოწვევა არის ემოციური დამოკიდებულების თავიდან აცილება.",
  
  artemis = "შენ ხარ თავისუფალი და დამოუკიდებელი სული. არ გიყვარს შეზღუდვები და აფასებ საკუთარ სივრცეს. ძლიერი ხარ მაშინ, როცა მარტო მოქმედებ. შენი გამოწვევა არის სხვებთან ღრმა კავშირის დაშვება.",
  
  poseidon = "შენ ხარ ღრმა და ინტენსიური. ემოციები შენში ძლიერად მოძრაობს, როგორც ოკეანე. შეგიძლია იყო როგორც მშვიდი, ისე ქაოსური. შენი გამოწვევა არის ემოციების დაბალანსება."
)

# -------------------------------
# კითხვები (12)
# -------------------------------
questions <- list(
  list(text="როგორ იქცევი რთულ სიტუაციაში?",
       choices=c("ვიღებ კონტროლს"="zeus","ვგეგმავ"="athena","ვმოქმედებ"="ares","ვგრძნობ"="aphrodite","ვშორდები"="artemis","ვრეაგირებ ძლიერად"="poseidon")),
  
  list(text="რა გაძლევს ძალას?",
       choices=c("ძალაუფლება"="zeus","ცოდნა"="athena","მოქმედება"="ares","სიყვარული"="aphrodite","თავისუფლება"="artemis","ემოცია"="poseidon")),
  
  list(text="როგორი ხარ ურთიერთობებში?",
       choices=c("დომინანტი"="zeus","გონივრული"="athena","ვნებიანი"="ares","რომანტიკული"="aphrodite","დამოუკიდებელი"="artemis","ინტენსიური"="poseidon")),
  
  list(text="რა გაღიზიანებს?",
       choices=c("კონტროლის დაკარგვა"="zeus","უცოდინრობა"="athena","უმოქმედობა"="ares","უსიყვარულობა"="aphrodite","დამოკიდებულება"="artemis","სიცივე"="poseidon")),
  
  list(text="როგორ იღებ გადაწყვეტილებებს?",
       choices=c("სწრაფად"="zeus","ანალიზით"="athena","ინსტინქტით"="ares","გრძნობით"="aphrodite","დამოუკიდებლად"="artemis","იმპულსით"="poseidon")),
  
  list(text="შენი მთავარი ღირებულება?",
       choices=c("ძალა"="zeus","სიბრძნე"="athena","ქმედება"="ares","სიყვარული"="aphrodite","თავისუფლება"="artemis","სიღრმე"="poseidon")),
  
  list(text="როგორ მოქმედებ ჯგუფში?",
       choices=c("ვხელმძღვანელობ"="zeus","ვგეგმავ"="athena","ვამოძრავებ"="ares","ვაერთიანებ"="aphrodite","ვრჩები დამოუკიდებელი"="artemis","ვქმნი ემოციურ დინამიკას"="poseidon")),
  
  list(text="როგორ აღიქვამ სამყაროს?",
       choices=c("იერარქია"="zeus","სისტემა"="athena","ბრძოლა"="ares","სიყვარული"="aphrodite","თავისუფლება"="artemis","ქაოსი"="poseidon")),
  
  list(text="რა გაძლევს მოტივაციას?",
       choices=c("მმართველობა"="zeus","გაგება"="athena","მოქმედება"="ares","კავშირი"="aphrodite","დამოუკიდებლობა"="artemis","ინტენსივობა"="poseidon")),
  
  list(text="როგორ რეაგირებ სტრესზე?",
       choices=c("ვაკონტროლებ"="zeus","ვფიქრობ"="athena","ვმოქმედებ"="ares","ვგრძნობ"="aphrodite","ვშორდები"="artemis","ვფეთქდები"="poseidon")),
  
  list(text="რა არის შენი სუსტი მხარე?",
       choices=c("დომინანტობა"="zeus","გადაფიქრება"="athena","იმპულსურობა"="ares","დამოკიდებულება"="aphrodite","იზოლაცია"="artemis","ემოციური ქაოსი"="poseidon")),
  
  list(text="რას აფასებ ადამიანებში?",
       choices=c("ძალა"="zeus","ინტელექტი"="athena","სიმამაცე"="ares","სილამაზე"="aphrodite","თავისუფლება"="artemis","სიღრმე"="poseidon"))
)

# -------------------------------
# UI
# -------------------------------
ui <- fluidPage(
  theme = bslib::bs_theme(
    bootswatch = "darkly",
    primary = "#C9A96E",
    base_font = bslib::font_google("Cormorant Garamond")
  ),
  
  # 👉 ეს ჩასვი ზუსტად აქ
  tags$head(
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1, viewport-fit=cover"),
    tags$style(HTML("
      body {
        background-color: #0f0f0f;
        padding-top: 70px; /* ეს აგვარებს ზემოთ მიბჯენას */
        padding-left: 10px;
        padding-right: 10px;
      }

      .container, .container-fluid {
        padding-left: 10px !important;
        padding-right: 10px !important;
      }

      .card {
        border-radius: 20px;
        background-color: #1c1c1c;
        box-shadow: 0 0 20px rgba(201,169,110,0.15);
        padding: 15px;
      }

      h1 {
        color: #C9A96E;
        text-align: center;
        margin-bottom: 10px;
      }

      h4 {
        color: #aaa;
        text-align: center;
        margin-bottom: 25px;
      }

      .btn-warning {
        background-color: #C9A96E;
        border: none;
        color: black;
        font-weight: bold;
        border-radius: 12px;
        padding: 12px;
      }

      .btn-warning:hover {
        background-color: #e0c48a;
      }

      .form-check {
        margin-bottom: 10px;
        font-size: 16px;
      }
    "))
  ),
  
  # 👉 აქიდან იწყება შენი არსებული UI (არ შეცვალო ქვემოთ)
  div(style="text-align:center; margin-bottom:30px;",
      h1("🏛️ არქეტიპის ტესტი"),
      p("გაიგე შენი ფსიქოლოგიური არქეტიპი")
  ),
  
  fluidRow(
    column(6, offset = 3,
           div(class="card p-4",
               uiOutput("questions_ui"),
               br(),
               actionButton("go","შედეგის ნახვა", 
                            class="btn btn-warning btn-lg w-100")
           )
    )
  ),
  
  br(),
  
  fluidRow(
    column(6, offset = 3,
           div(class="card p-4",
               h2(textOutput("result_main")),
               h3(textOutput("result_second")),
               br(),
               p(textOutput("desc_main")),
               br(),
               p(textOutput("desc_second"))
           )
    )
  )
)

# -------------------------------
# SERVER
# -------------------------------
server <- function(input, output){
  
  output$questions_ui <- renderUI({
    lapply(seq_along(questions), function(i){
      radioButtons(paste0("q",i), questions[[i]]$text, choices=questions[[i]]$choices)
    })
  })
  
  result <- eventReactive(input$go,{
    scores <- setNames(rep(0,length(archetypes)), archetypes)
    
    for(i in seq_along(questions)){
      ans <- input[[paste0("q",i)]]
      if(!is.null(ans)){
        scores[ans] <- scores[ans] + 1
      }
    }
    
    sort(scores, decreasing = TRUE)
  })
  
  output$result_main <- renderText({
    req(result())
    res <- result()
    top <- names(res)[1]
    percent <- round(res[1]/sum(res)*100)
    
    paste0("შენი წამყვანი არქეტიპია: ", titles[top], " (", percent, "%)")
  })
  
  output$result_second <- renderText({
    req(result())
    res <- result()
    second <- names(res)[2]
    percent <- round(res[2]/sum(res)*100)
    
    paste0("მეორე არქეტიპი: ", titles[second], " (", percent, "%)")
  })
  
  output$desc_main <- renderText({
    req(result())
    descriptions[names(result())[1]]
  })
  
  output$desc_second <- renderText({
    req(result())
    descriptions[names(result())[2]]
  })
}

shinyApp(ui, server)
