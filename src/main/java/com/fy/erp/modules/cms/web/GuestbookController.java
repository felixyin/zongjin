/**
 *
 */
package com.fy.erp.modules.cms.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fy.erp.common.persistence.Page;
import com.fy.erp.common.utils.StringUtils;
import com.fy.erp.common.web.BaseController;
import com.fy.erp.modules.cms.entity.Guestbook;
import com.fy.erp.modules.cms.service.GuestbookService;
import com.fy.erp.modules.sys.utils.DictUtils;
import com.fy.erp.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 留言Controller
 * @author ThinkGem
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/guestbook")
public class GuestbookController extends BaseController {

	@Autowired
	private GuestbookService guestbookService;
	
	@ModelAttribute
	public Guestbook get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return guestbookService.get(id);
		}else{
			return new Guestbook();
		}
	}
	
	@RequiresPermissions("cms:guestbook:view")
	@RequestMapping(value = {"list", ""})
	public String list(Guestbook guestbook, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Guestbook> page = guestbookService.findPage(new Page<Guestbook>(request, response), guestbook);
        model.addAttribute("page", page);
		return "modules/cms/guestbookList";
	}

	@RequiresPermissions("cms:guestbook:view")
	@RequestMapping(value = "form")
	public String form(Guestbook guestbook, Model model) {
		model.addAttribute("guestbook", guestbook);
		return "modules/cms/guestbookForm";
	}

	@RequiresPermissions("cms:guestbook:edit")
	@RequestMapping(value = "save")
	public String save(Guestbook guestbook, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, guestbook)){
			return form(guestbook, model);
		}
		if (guestbook.getReUser() == null){
			guestbook.setReUser(UserUtils.getUser());
			guestbook.setReDate(new Date());
		}
		guestbookService.save(guestbook);
		addMessage(redirectAttributes, DictUtils.getDictLabel(guestbook.getDelFlag(), "cms_del_flag", "保存")
				+"留言'" + guestbook.getName() + "'成功");
		return "redirect:" + adminPath + "/cms/guestbook/?repage&status=2";
	}
	
	@RequiresPermissions("cms:guestbook:edit")
	@RequestMapping(value = "delete")
	public String delete(Guestbook guestbook, @RequestParam(required=false) Boolean isRe, RedirectAttributes redirectAttributes) {
		guestbookService.delete(guestbook, isRe);
		addMessage(redirectAttributes, (isRe!=null&&isRe?"恢复审核":"删除")+"留言成功");
		return "redirect:" + adminPath + "/cms/guestbook/?repage&status=2";
	}

}
