const http = require('http');
const hostname = 'localhost';
const port = 3000;

const helpText = `
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Stackbill Marketplace</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@100;200;300;400;500;600;700;800;900&display=swap"
      rel="stylesheet"
    />
  </head>
  <body style="overflow: hidden !important; padding: 0px">
    <div
      style="
        width: 100vw;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        font-family: 'Public Sans', sans-serif;
        background-color: #fff;
        color: rgb(8, 27, 75);
        font-size: 30px;
      "
    >
      <svg
        width="947"
        height="772"
        viewBox="0 0 947 772"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink"
      >
        <rect width="947" height="772" fill="url(#pattern0)" />
        <defs>
          <pattern
            id="pattern0"
            patternContentUnits="objectBoundingBox"
            width="1"
            height="1"
          >
            <use
              xlink:href="#image0_8_4"
              transform="translate(-0.0790988) scale(0.000282763 0.000346861)"
            />
          </pattern>
          <image
            id="image0_8_4"
            width="4096"
            height="2883"
          />
        </defs>
      </svg>

      <h1>Welcome to MarketPlace</h1>
    </div>
  </body>
</html>
`

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/html');
  res.end(helpText);
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});