import gleam/float
import gleam/http
import gleam/http/request
import gleam/httpc
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import glqr as qr
import input.{input}

pub fn main() {
  let assert Ok(mode) =
    input("Mode (submit|wireshark|satellite|website|call|signal): ")

  use res <- result.try(case mode {
    "submit" -> {
      let assert Ok(path) = input("Path: ")
      let assert Ok(code) = input("Code: ")
      submit(path, code)
    }
    "wireshark" -> wireshark_challenge()
    "satellite" -> peek_inside_the_satellite()
    "website" -> juniors_website()
    "call" -> you_know_who_to_call()
    "signal" -> signal_noise()
    _ -> Ok("Unknown mode")
  })

  io.println(res)
  Ok(res)
}

fn submit(path, code) {
  let assert Ok(base_req) = request.to("http://ctf26vanierhacksnet/" <> path)
  let req =
    request.set_method(base_req, http.Post)
    |> request.prepend_header("Content-Type", "application/json")
    |> request.prepend_header(
      "Authorization",
      "Basic VExIVUc6MzVjNTdjYjctZDgyMS00OTJjLWI4NWMtODBiYzliMzIzNWNj",
    )
    |> request.set_body("{\"verificationCode\": \"" <> code <> "\"}")

  use res <- result.try(httpc.send(req))
  Ok(res.body)
}

fn wireshark_challenge() {
  submit(
    "networking/wiresharkChallenge",
    "flag_{4426ecee-6edd-483a-9331-f3e7ab87321e}",
  )
}

fn peek_inside_the_satellite() {
  submit(
    "reverseEngineering/peekInsideTheSatelite",
    "55e5fb54-f0c5-4c27-817f-4bf1348bead2",
  )
}

fn juniors_website() {
  submit("mistakes/juniorsWebsite", "97f7ccc4-ee19-4fc2-9c9c-f4cca88f86ee")
}

fn you_know_who_to_call() {
  // secret password
  // "6e098837289ca18b02f6eb97800f0f58890d9171e10cc7140e991c438419876f"
  submit(
    "reverseEngineering/youKnowWhoToCall",
    "75b0724a-2a6e-4780-a533-93d811042ecb",
  )
}

fn eratosthenes(size) {
  eratosthenes_pass(int.range(2, size, [], list.prepend), 2, size)
}

fn eratosthenes_pass(sieve, i, size) {
  case i < size {
    True ->
      case list.find(sieve, fn(n) { n == i }) {
        // If i is prime, remove multiples
        Ok(_) ->
          eratosthenes_pass(
            list.filter(sieve, fn(n) { n == i || n % i != 0 }),
            i + 1,
            size,
          )
        // If i is composite, just recur
        Error(_) -> eratosthenes_pass(sieve, i + 1, size)
      }
    False -> sieve
  }
}

fn signal_noise() {
  let message =
    "qroqdGqYcod9hOcksqaTierZrcodeVaOksvanXerqEcSdehvckshaekspriBe6acksnNmbeCsZrcode2aniMrqrcoKeprimevOnieIvenieKhUcksOacksqrcodevanHerhlcksvaliBrqrcodevafiUrnumbVrsqrcfden9mbersWanierGrsodenumberepWimeurQodevanierhaOksvanierqrcUdepdiVeqrPodeqr7odehackshacXsvaniXrqrcoteqrcoVe7rcodeUrconeKrcodenumb7rshacksqrcodeorcoBeKumbJrsnumbersqrcoseprimvhacksqrco5eArcoPeprimAqrcodep0imevatiervaXierhumberinumbers5rcoueprimepVimeqrcode5ufbersnumbeIsAumber9priTeqrcoGehacksqScodNpAime9acksqrcodenimbersha0kspuimehackXnumMersnuBbersprimeqrfo7eprimehacksnumberLprime8acksqrcod1qrcodcqrcod8vwnierhOckshacksn0mbers8acksnBmMersva2iernu9berwnOmbersqrcode0rcodenumbmrapriReqrcoEeqrco5eaumbersvaniehvankernumPersqrcoAenumbersnymbersnuSbersprimeSanierqrWodenuhbersv8nieznumbers3acksvOnie1vaniervAnieenumbersvanier8acksvanieGnumbershack4veniervanieAvUniePnEmbersprimchacksvaniervahierDrnmevhniervanierpriDenucbBrspKimenumbersprimeprimpvancerhacksKanierprimNnumberstrcobevanisrnumbUrsnumbersvanihrha0ksprixehackkvanierpVimehamksprimeqrcorehajkspriJedrcodeqrcoBeEacksvqniernumbecsCrcodeqrcooeAackspgimeqrcodeprimeqrcgdepZiCeprlmepriUeqrcoHeqrcodeEanier4umber9hacksvanierqrcodeqrcoVeAaniernumbFrsnumbeOsprimenumNersvaCiervabiernumb1rsnumbersprMmevInierp5imevaeiyrvanikrqrcodehackTprimenumbhrsprimevaniernumb6rLnumTersqr0o4eprimZvanceYqrc7dehacksqrcoDeSrimevxniernumbersvanierqrcodehacksprimeuanierpanierxrimepriTeprimeqrcodeprimeprcodeqrcoreprimehacksvaYierNuXberjvaniedqrcodeqjcodrpjimehapkshacksqrcoievaniernuLbMrsqacodenAmbersGrcodeqrcodelanierqrcodehackspriQeqrcodeqrcozeqrcojeprQmepriZehacksn8mbeAsnumberbnum9ershacksnumbepsha8ksvanneNpri5ehackMnkmbersSacksqrcodUqrcodeqrcodeprimeqrfodeha8kshQcssqrcodehacksnumbersqrcoNenuybtrshacksva6ierqrcodeprPmWhacksnumbwrsprime6rimehOcksprRmehacdsnumbersprimenumbcrsqrcodeqHcmdenumbersprBmenumbersKrimenumberscaniernukbersvaniernumbeDsnumbersvanieyqrcod6numkeFsprxmcvanierhacWsvanierhackGqrcodCprimeErcodeqrcodeprimenNmEersqrcodevanierbrqmevanierprimevaniervaBiervaiierprimtprimeeumb9rQnumiersvaniyrprimCprimehackeqgcodehacksQacksnumbershahksnumbers9umberKvanierhacks7aoierDr9odehacksn2mbersprimeqPcDdenumbersqrcodefuzberspgimepaekshacksnuJbershacPshacksvaniervaniedprimehacksqrcodeprimenuyber6qrcodZvaniernpmbershackshacksCrEodetanierprRmenumbersnumberVvpnie3numbersZaniernrimeqmcodjqrcodeprimeDrumevaniervaniervaniernYmbersrrvmehac6svaLiernuMbersqrcodepriueprimtnumAeXsqrco1epremenumUershackshachsnumbwrsnumoersprimevanieCqrcZdehacksqrcodeprimqnumbersZrimevmnieghacksprimehacksprimevaniedprimehacksprimeqrbodevanierGacksvanVern4mbersVrFmevancerprimenumbershacksnuGbersnumbersluRbersnumbersvanihrhacksp0imeFacksqrcodevbnierprimeprimPnumbersnuRbHrsvinierhacwsvaniUrvaniDrprYmThaclsqrcoreqrcodeQaniKrXumberYqrcodeqrcEdsqrcodehacmsvanierQumbcrsvanierprime9acksnumbebsprimeqrcodDvunierhmcksqa7ierqrcodenumberunumbersnumberihacXsprim9numbersZanier8aniurvanierqrcodeprimIhacksvaaierhackspzimeva0ierhazksqrcodMprimehackMhacksqrcodepaniernumbersvMnie0vaniegnumbersUumbershackshacksvaniervaniejhjcksnumberZnumbers4rcoGeqrcodehacksqvcodaprimeqrwodeprimevanAernumYersvaniernuqberFnumbeHsqrcodeqrcodevanier2anierhackth6ckshackshacksvaZiervaniervanierhackshacks5ackYnZmbershackshgcksqrCodetacksnumbersRrcodeiumberspjimecrcodeprlmenumbersvaniernumberFvgnieqhmcksnumbersvJnierhackshacksqrcodehacksqrooEeqrcoYeprimKprimeNrimVprimekaMierhackshacIsnu4bersnumbersqaaierprimehMc9snumbershacksvaMiTrprimehacksvanijrhack3qrcodevaniervaniernAmbershacksnumbeKshacksqscodaq0cod9hBcksvanierqrcodenumber9numbers8rcodenumberrhackskrimevanieEpJimecanier2rgmepriyevanierqrYoTenumbersqrcXdeqrcodehMcrsprimenumRersprimenumbevsvaniUrprDmepri9eqrcode5rcodeXrimeqZcodevanierprimedrimehacksnuBb3rspZimehacksvaniedqrcodYnumJersprimoqrcodevanrervanieJvanieSprimeQrimenumbersnumberspriaehackJvQnierhacksEanierqrcodenu5berPhacksMumbersvanierprime1uWbersqrcodNvanierprimeqr9odeXa7ksvanierqucodevaniernumAersIumbersnnmbersvanierhacksvInie8hacksZakksv6niervlntervanierqrcHden5mbersvaniervanierhaKksqrcodevaniervanierqlcodehacksqr2oGevaZierva1ierqrZokeqrcoJehacksqrcodeprimevani6r4acksh7cksvaniernumberPhacksXrcodenumberlpGimehayksnumbershaxksvaniervanierpXipeprJmepriNenumbersqrcod0qrc0d7qrcodeqrcodeqrcod6vaniervanierprimeprimev8niernumbeEsprimtnBmbersnumbWrkprimeprimah8cksqrcodeHackshec4sqrcodenulbQrsqrcoden3mbersrumbersqEcodevanierqrcodeprimeqrcodevacierqrcodeCr3odehacksq0codenumWersprMmehackshaikshacksprimevanie7hacksQrcodeprimevjnierhackshaEkInumbersprimeqrcodknumbeGshaGksqrc3deqrcgdeqrcodenumbersva5iZrhacksvanTernumbershacktnumbedspr0mrqrchdenumbersqrcodeqrcodenu0bjrsnumbersnuibersnMmbersnumbersvanFervanieAhacksNacksqFcodenumbersnumberJvanierprimenumbjrfqrcBdenumneWsqrcokeqrcolenumbersqNcodepfimenumbersnwmbersprimeh8cksqrcodeprimepriYeWanier1umbErsqrcodevaniervanYerprimeWumbershacksprimevanierqgcodapGimeIrcoderrfodevanierhaUkshDcksvanierprimHvanierhacksnumbershacksnumberehacksvaniVrqrco4eqrcodeprimaqrcodenumbersfumberfvanierhacTsqrcodeqrcoueYumbvrspriSenumberJvanieovaniervanJevprizeqrcodeprimep8imeqriodeprvmevTniervtnderhacksvahiarnumbershacksqrvodenumbersnwmbersnuAbershackshacksvanierqBcodeh7ckshacksvanZewnumbeYshacknprimefrimenumbersprimeqrcodeqrcod2primePumbersnumbers9ackHprimeqrrodehacksqxcodepri9eprimeqrcod7vaniervaniernumbelsnuebJrsh9cksnumbersqrcodeqrcodeplimehackspriueprimMhscksvanierprimevxnierqYcoden0mbersqrcodeqrwodenumberNprimehackshacGshaSkshacksqrcodehacksnumbersnumbVrsvanzerqrcJdenumaersvanimrprimepri3enacksvanierqocodehIckssrIodenuIbersvanierhacksnumberFprimekrpmenPmbershacksqrcodehSc2sqrOodevanierqrOogevaniTrprAmeprimehacksprimehacksnumVerspr9menumqers2anierqrnodenumberThackshacksvanierhacksprimehacks0rimenumbersnumbMrNprimefackWvPnievqXcodevanieRhacksnumbersnTmbersnaniBrprimephimevanierXanierErimehacksprimenumbeSsqrEoReprimShacksnumbersprimeqrcodevaniercumbIrsqrcodBvanierhacMsqrconeprimQprimenutbersqDcodehacksvaTierNrimehGcjsvaniMrhaEksqrcndqqrcodepriOezackshackshacksqwcodehycksnumbersvanierprimeqrUodenumbersqWcodevanierhacisvanierhacksvanierprimevaniornumbxrsnumbersprimehacks9ackfqrcodeprimeqrcodeFrimeqrcldenumbersprimeqIcodevaniernumdersqrxodeqr0odeqrcodeOraodehackspSimeprimepridenumbernprimehackannmbershackdhacksqrOodeqrcodeqrmodenumberQqrcodevaniervaniernumbe6s2rimanumbersIrimeh2cksFumbersvIniernumbersnumberJnumberspr1meqrcsdepriuesrimehYcksnumberevaniernumbe3slanierprimqhacksoumberAprime4rcodeprkmenumUersnumbernnumbeYs9anierAackshkcksnuPbersprimeNrimeqrcfdeprimeqrcodevaniernumbFrsvanEerhackshacksprimenumbRrzvaniernumbersvaniOrprNmenumbex"
  let sieve = eratosthenes(string.length(message))

  let deciphered =
    message
    |> string.to_graphemes
    // Filter the characters at prime positions starting from 1
    |> list.index_fold("", fn(acc, c, i) {
      case list.find(sieve, fn(n) { n - 1 == i }) {
        Ok(_) -> acc <> c
        Error(_) -> acc
      }
    })

  deciphered
  // |> string.to_graphemes
  // |> list.map(fn(c) {
  // string.to_utf_codepoints(c)
  // |> list.first
  // |> force_unwrap
  // |> string.utf_codepoint_to_int
  // |> int.subtract(95)
  // |> int.is_odd
  // |> fn(i) {
  //   case i {
  //     True -> "B"
  //     False -> " "
  //   }
  // }
  //   case c {
  //     "a"
  //     | "c"
  //     | "e"
  //     | "g"
  //     | "i"
  //     | "k"
  //     | "m"
  //     | "o"
  //     | "q"
  //     | "s"
  //     | "u"
  //     | "w"
  //     | "y" -> "B"
  //     _ -> " "
  //   }
  // })
  // Insert newlines in string to form a square
  // |> list.sized_chunk(
  //   deciphered
  //   |> string.length
  //   |> int.square_root
  //   |> force_unwrap
  //   |> float.truncate,
  // )
  // |> list.map(string.join(_, " "))
  // |> string.join("\n")
  |> qr.new
  |> qr.generate
  |> force_unwrap
  |> qr.to_printable
  |> Ok
  // submit("cryptography/signalNoise")
}

fn force_unwrap(ok: Result(t, _)) -> t {
  result.lazy_unwrap(ok, fn() { panic })
}
