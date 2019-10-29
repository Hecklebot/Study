package bitcamp.chopchop.web;

import java.io.File;
import java.util.List;
import java.util.UUID;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import bitcamp.chopchop.domain.Pet;
import bitcamp.chopchop.service.PetService;

@Controller
@RequestMapping("/pet")
public class PetController {

  @Resource
  private PetService petService;

  String uploadDir;

  public PetController(ServletContext sc) {
    uploadDir = sc.getRealPath("/upload/pet");
  }

  @GetMapping("form")
  public void form() {
    
  }

  @PostMapping("add")
  public String add(Pet pet) throws Exception {
    petService.insert(pet);
    return "redirect:list";
  }

  @GetMapping("list")
  public void list(Model model) throws Exception {
    List<Pet> pet = petService.list();
    model.addAttribute("pets", pet);
  }

  @RequestMapping("detail")
  public void detail(Model model, int no) throws Exception {
    Pet pet = petService.get(no);
    model.addAttribute("pet", pet);
  }

  @PostMapping("update")
  public String update(Pet pet, MultipartFile file) throws Exception {
    pet.setPhoto(writeFile(file));
    petService.update(pet);
    return "redirect:list";
  }

  private String writeFile(MultipartFile file) throws Exception {
    if (file.isEmpty())
      return null;

    String filename = UUID.randomUUID().toString();
    file.transferTo(new File(uploadDir + "/" + filename));
    return filename;
  }
}
