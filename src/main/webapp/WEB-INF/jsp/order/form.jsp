<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<html>
<head>
  <title>주문 폼</title>
  <link rel='stylesheet' href="/node_modules/bootstrap/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/member/style_contact.css">
  <link rel="stylesheet" href="/css/member/style_footer.css">
  <style>
  
    #textbox {
      width: 500px;
    }
    
    #radio-button {
      width:40px;
    }
    
    #memberInfo {
      width:600px;
      margin:0px;
      display:relative;
    }
    
    #recipientInfo {
      position: relative;
      left: 700px;
      bottom: 670px;
      width: 600px;
    }
    
    #orderForm {
      width:1100px; 
      display: table; 
      margin-left: auto; 
      margin-right: auto; 
    }
    
  </style>
</head>
<body>
  <jsp:include page="../header.jsp"/>
  
  <form action="add" method="post" id="orderForm">
      <input type="hidden" name="quantity" value="${quantity}">
      <input type="hidden" name="memberNo" value="${loginUser.memberNo}">
      <table class='table table-bordered' style="width:1100px; display: table; margin-left: auto; margin-right:auto;">
    <tr>
      <td>상품</td>
      <td>상품 가격</td>
      <td>수량</td>
      <td>할인률</td>
      <td>결제 금액</td>
    </tr>
    <tr>
      <td>${product.title}</td>
      <td>${product.price}원</td>
      <td>${quantity}</td>
      <td>${product.discount}%</td>
      <td><span style="text-decoration-line:line-through; color:gray;">${product.price * quantity}원</span><br>
      <span id="totalPrice">${product.price * quantity * (100-product.discount)/100}</span>원</td>
    </tr>
  </table>
<!--     <div style="display: table; margin-left: auto; margin-right:auto;"> -->
      <div class="row">
      <div class="col-md-6">
        <label for="exampleInput">주문자 이름</label>
        <input type="text" id="customerName" value="${loginUser.nickname}">
      </div>
      <div class="col-md-6">
        <label for="exampleInput">수령인 이름</label>
        <input type="text" id="recipientName" name="nickname" value="" placeholder="이름을 입력하세요.">
      </div>
      </div>
      <div class="row">
        <div class="col-md-6">      
          <label for="exampleInput">주문자 이메일</label>
          <input type="text" id="customerEmail" name="" value="${loginUser.email}">
        </div>
        <div class="col-md-6">      
          <label for="exampleInput">수령인 이메일</label>
          <input type="text" id="recipientEmail" name="email" value="" placeholder="이메일을 입력하세요."></div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <label for="exampleInput">주문자 연락처</label>
          <input type="text" id="customerTel" name="" value="${loginUser.tel}">
        </div>
        <div class="col-md-6">      
          <label for="exampleInput">수령인 연락처</label>
          <input type="text" id="recipientTel" name="tel" value="" placeholder="연락처를 입력하세요."></div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <label for="exampleInput">우편번호</label>
          <input type="text" id="customerPostNo" name="" value="${loginUser.postNo}">
        </div>
        <div class="col-md-6">      
          <label for="exampleInput">수령인 우편번호</label>
          <input type="text" id="recipientPostNo" name="postNo" value="" placeholder="우편번호를 입력하세요."></div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <label for="exampleInput">기본주소</label>
          <input type="text" id="customerBaseAddress" name="" value="${loginUser.baseAddress}">
        </div>
        <div class="col-md-6">      
          <label for="exampleInput">수령인 기본주소</label>
          <input type="text" id="recipientBaseAddress" name="baseAddress" value="" placeholder="기본주소를 입력하세요."></div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <label for="exampleInput">상세주소</label>
          <input type="text" id="customerDetailAddress" name="" value="${loginUser.detailAddress}">
        </div>
        <div class="col-md-6">
          <label for="exampleInput">수령인 상세주소</label>
          <input type="text" id="recipientDetailAddress" name="detailAddress" value="" placeholder="상세주소를 입력하세요.">
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <label for="exampleInput">결제수단</label>
          <input type="radio" id="radio-button" name="paymentMethod" value="신용카드">신용카드
          <input type="radio" id="radio-button" name="paymentMethod" value="무통장 입금">무통장 입금
          <input type="radio" id="radio-button" name="paymentMethod" value="간편결제">간편결제
        </div>
        <div class="col-md-6">      
          <label for="exampleInput">주문자 정보와 동일<input type="checkbox" id="checkBox" style="width:30px;" disabled></label>
        </div>
      </div>
      <br><br>
      <hr>
      <br><br>
      관리자<br><br>
      <div class="row">
      <div class="col-md-6">
<!--       <label for="exampleInput">입금일</label><input type="date" id="textbox" name="paymentDate"> -->
      </div>
      <div class="col-md-6">
      <label for="exampleInput">주문상태</label>
      <select id="selectBox" name="shipDate" class="form-control">
        <option value="${order.shipDate}">입금 전</option>
        <option value="${order.shipDate}">입금 확인</option>
        <option value="${order.shipDate}">발송</option>
        <option value="${order.shipDate}">배송완료</option>
      </select>
      </div>
      </div>
      <div>
        <input type="hidden" id="textbox" name="no" value="${product.productNo}">
        <input type="hidden" id="textbox" name="discount" value="${product.discount}">
        <button class="btn btn-success">주문</button>
        <a href="../product/detail?no=${product.productNo}" class="btn btn-danger" style="margin-left:30px;">취소</a>
      </div>
      <input type="hidden" name="optionNo" value=1>
      <input type="hidden" name="quantity" value="${quantity}">
      <input type="text" id="discountPrice" name="discountPrice" value="${product.price * quantity * (100-product.discount)/100}">
<!--     </div> -->
  </form>
  <jsp:include page="../footer.jsp"/>
  <script>
    var totalPrice = document.querySelector('#totalPrice');
    var resultPrice = parseInt(totalPrice.innerText);
    totalPrice.innerText = resultPrice;
    
    var discountPrice = document.querySelector('#discountPrice');
    discountPrice.value = parseInt(discountPrice.value);
    
  </script>
  
  <script>
    var checkBox = document.querySelector('#checkBox');
    if(!(${loginUser.memberNo} == 0)) {
      checkBox.removeAttribute("disabled")
    }

    checkBox.addEventListener('change', function(){
      if(checkBox.checked) {
        document.querySelector('#recipientName').value = document.querySelector('#customerName').value;
        document.querySelector('#recipientEmail').value = document.querySelector('#customerEmail').value;
        document.querySelector('#recipientTel').value = document.querySelector('#customerTel').value;
        document.querySelector('#recipientPostNo').value = document.querySelector('#customerPostNo').value;
        document.querySelector('#recipientBaseAddress').value = document.querySelector('#customerBaseAddress').value;
        document.querySelector('#recipientDetailAddress').value = document.querySelector('#customerDetailAddress').value;
      } else {
        document.querySelector('#recipientName').value = "";
        document.querySelector('#recipientEmail').value = "";
        document.querySelector('#recipientTel').value =  "";
        document.querySelector('#recipientPostNo').value =  "";
        document.querySelector('#recipientBaseAddress').value =  "";
        document.querySelector('#recipientDetailAddress').value =  "";

      }
    })

  </script>
  
  
  
  
  
  
  
  
  
  
  
  
  
</body>
</html>