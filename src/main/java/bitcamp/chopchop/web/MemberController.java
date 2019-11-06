package bitcamp.chopchop.web;

import java.io.File;
import java.util.List;
import java.util.UUID;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import bitcamp.chopchop.domain.Member;
import bitcamp.chopchop.domain.Pet;
import bitcamp.chopchop.domain.Pet2;
import bitcamp.chopchop.service.MemberService;
import bitcamp.chopchop.service.Pet2Service;
import bitcamp.chopchop.service.PetService;

@Controller
@RequestMapping("/member")
public class MemberController {

  @Resource
  private MemberService memberService;
  @Resource
  private Pet2Service pet2Service;
  @Resource
  private PetService petService;

  String uploadDir;

  public MemberController(ServletContext sc) {
    uploadDir = sc.getRealPath("/upload/member");
  }

  @GetMapping("myProfile")
  public void myProfile() {}
  
  @GetMapping("form")
  public void form() {
  }

  @PostMapping("add")
  public String add(Member member) throws Exception {
    memberService.insert(member);
    return "redirect:list";
  }

  @GetMapping("list")
  public void list(Model model) throws Exception {
    List<Member> members = memberService.list();
    model.addAttribute("members", members);
    List<Pet> pets = petService.list();
    model.addAttribute("pets", pets); 
  }

  @GetMapping("contact")
  public void contact(Model model, HttpSession session) throws Exception {
    Member member = (Member) session.getAttribute("loginUser");
    model.addAttribute("member", member);
  }
  
  @RequestMapping(path = "sendMail",
  method = RequestMethod.POST)
  public void sendMail(Model model) throws Exception {
    memberService.sendMail();
  }

  @GetMapping("dupE")
  public @ResponseBody int dupEmailCheck(String email) throws Exception {
    return memberService.dupEmailCheck(email);
  }

  @GetMapping("dupN")
  public @ResponseBody int dupNicknameCheck(String nickname) throws Exception {
    return memberService.dupNicknameCheck(nickname);
  }

  @RequestMapping(value = "signE", method = RequestMethod.GET)
  public @ResponseBody int signEmailCheck(String email) throws Exception {
    return memberService.signEmailCheck(email);
  }

  @RequestMapping(value = "signP", method = RequestMethod.GET)
  public @ResponseBody int signPasswordCheck(String password) throws Exception {
    return memberService.signPasswordCheck(password);
  }

  @RequestMapping("detail")
  public void detail(Model model, int no) throws Exception {
    Member member = memberService.get(no);
    List<Pet2> pets = pet2Service.getPets(no);
    model.addAttribute("member", member);
    model.addAttribute("pets", pets);
  }

  @PostMapping("update")
  public String update(Member member, MultipartFile file) throws Exception {
    member.setPhoto(writeFile(file));
    memberService.update(member);
    return "redirect:list";
  }

  private String writeFile(MultipartFile file) throws Exception {
    if (file.isEmpty())
      return null;

    String filename = UUID.randomUUID().toString();
    file.transferTo(new File(uploadDir + "/" + filename));
    return filename;
  }

  @GetMapping("delete")
  public String delete(int no) throws Exception {
    memberService.delete(no);
    return "redirect:list";
  }

  @PostMapping("chkPw")
  public @ResponseBody int chkPw(String password, int memberNo) throws Exception {
    return memberService.chkPw(password, memberNo);
  }

  @PostMapping("uptPw")
  public @ResponseBody int uptPw(String password, int memberNo) throws Exception {
    return memberService.uptPw(password, memberNo);
  }

  
}
