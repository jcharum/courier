package org.coursera.courier;

import com.intellij.openapi.actionSystem.AnAction;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.actionSystem.CommonDataKeys;
import com.intellij.openapi.fileEditor.FileEditorManager;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiClass;
import com.intellij.psi.PsiElement;
import org.coursera.courier.psi.CourierTypeNameDeclaration;

import javax.annotation.Nonnegative;
import javax.annotation.Nullable;
import java.util.List;

public class CourierScalaToCourierAction extends AnAction {
  @Override
  public void actionPerformed(AnActionEvent anActionEvent) {

    // Is this something that already refers directly to a Courier Type Declaration?
    PsiElement referentClassElement = anActionEvent.getData(CommonDataKeys.PSI_ELEMENT);
    if (referentClassElement instanceof CourierTypeNameDeclaration) {
      VirtualFile virtualFile = referentClassElement.getContainingFile().getVirtualFile();
      Project project = anActionEvent.getProject();
      FileEditorManager.getInstance(project).openFile(virtualFile, true);
    }

    // Is this something that refers to a Scala class generated from a Courier Type Declaration?
    // NB: "generated by" is over-approximated by "having the same name as the courier type"
    PsiClass referentClass = getReferentClass(referentClassElement);
    if (referentClass != null) {
      String referentClassName = getScalaClassName(referentClass);
      Project project = anActionEvent.getProject();
      List<CourierTypeNameDeclaration> declarations = CourierResolver.findTypeDeclarationsByName(project, referentClassName);
      if (declarations.size() > 0) {
        CourierTypeNameDeclaration declaration = declarations.get(0);
        VirtualFile virtualFile = declaration.getContainingFile().getVirtualFile();
        FileEditorManager.getInstance(project).openFile(virtualFile, true);
      }
    }
  }

  /**
   * Given a PsiElement, looks for the referent class.
   * Traverses up a few levels in case that class is hard to come by.
   */
  @Nullable
  private PsiClass getReferentClass(@Nullable PsiElement e) {
    return getReferentClass(e, 4);
  }

  @Nullable
  private PsiClass getReferentClass(@Nullable PsiElement e, @Nonnegative int maxHeight) {
    if (e == null) {
      return null;
    } else if (e instanceof PsiClass) {
      return (PsiClass) e;
    } else if (maxHeight == 0) {
      return null;
    } else {
      return getReferentClass(e.getParent(), maxHeight - 1);
    }
  }

  /**
   * Given a Java class or a Scala class OR object, gets the underlying class name.
   *
   * Object names have $ appended
   */
  private String getScalaClassName(PsiClass c) {
    String baseName = c.getName();
    return baseName.replaceAll("\\$", "");
  }

  @Override
  public void update(AnActionEvent anActionEvent) {
  }
}
